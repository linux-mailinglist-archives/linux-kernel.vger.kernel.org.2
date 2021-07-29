Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064703DA6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhG2Ox5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhG2Ox4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:53:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D572C60EBC;
        Thu, 29 Jul 2021 14:53:50 +0000 (UTC)
Date:   Thu, 29 Jul 2021 16:53:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     cgel.zte@gmail.com
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        jamorris@linux.microsoft.com, varad.gautam@suse.com,
        legion@kernel.org, dbueso@suse.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
Message-ID: <20210729145348.hvvhu6lmlcn5js4y@wittgenstein>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:06:51PM -0700, cgel.zte@gmail.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> When a non-root user process creates a user namespace and ipc namespace
> with command "unshare -Ur -i", and map the root user inside
> the user namesapce to the global owner of user namespace.
> The newly created user namespace OWNS the ipc namespace,
> So the root user inside the user namespace should have full access
> rights to the ipc namespace resources.
> 
> $ id
> uid=1200(u1200) gid=1200(u1200) groups=1200(u1200)
> $ unshare -Ur -i
> $ id
> uid=0(root) gid=0(root) groups=0(root)
> $ ls -l /proc/sys/fs/mqueue/
> total 0
> -rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msg_default
> -rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msg_max
> -rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msgsize_default
> -rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msgsize_max
> -rw-r--r-- 1 65534 65534 0 Jul 28 19:03 queues_max
> -sh: /proc/sys/fs/mqueue/msg_max: Permission denied
> 
> As opposite, inside a net namespace,
> 1. sysctl files owners are set to the local root user
>    insede the user namespace, not the GLOBAL_ROOT_UID;
> 2. sysctl files are writable when accessed by root user
>    inside the user namespace.
> 
> $ id
> uid=1200(u1200) gid=1200(u1200) groups=1200(u1200)
> $ unshare -Ur -n
> $ id
> uid=0(root) gid=0(root) groups=0(root)
> $ ls -l /proc/sys/net/ipv4/ip_forward
> -rw-r--r-- 1 root root 0 Jul 28 19:04 /proc/sys/net/ipv4/ip_forward
> $ echo 1 > /proc/sys/net/ipv4/ip_forward
> $ cat /proc/sys/net/ipv4/ip_forward
> 1

Yeah, we did that work specifically for the network namespace but knew
there were quite a few places that would need fix up. This makes sense
to me.

Please add tests for this patch though. Also make sure to run them in a
tight loop on a kernel with memory and log debugging enabled. The whole
sysctl retire stuff can't be called from rcu contexts and that's easy to
miss. So turn on at least sm like:

CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_STATIC_KEYS=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_LOCKDEP=y
