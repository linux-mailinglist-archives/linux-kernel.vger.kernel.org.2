Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB5333804
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhCJI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhCJI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:58:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27210C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:58:19 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lJufK-00EFAP-SV; Wed, 10 Mar 2021 09:58:03 +0100
Message-ID: <82649fa88c2583bb82f5ddd236d7e4b5a859e4e1.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: remove unneeded variable 'ret'
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yang Li <yang.lee@linux.alibaba.com>, jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 09:58:01 +0100
In-Reply-To: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-10 at 16:49 +0800, Yang Li wrote:
> Fix the following coccicheck warning:
> ./arch/um/drivers/hostaudio_kern.c:125:10-14: Unneeded variable: "mask".
> Return "0" on line 131

Word of caution to you:

You've already managed to be in various people's block list due to
sending patches such as

https://lore.kernel.org/linuxppc-dev/1614243417-48556-1-git-send-email-yang.lee@linux.alibaba.com/


You might want to stop for a while, and *really* carefully look at each
and every patch you send out.


In this case, you messed up the subject.

johannes

