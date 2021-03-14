Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF233A8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCNXI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:08:29 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49876 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCNXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:08:17 -0400
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DzFb46SYTzDq75;
        Sun, 14 Mar 2021 16:08:16 -0700 (PDT)
X-Riseup-User-ID: FDC205D484EEC47A4CB843E79EA3D06674ED5DC72F2DE7890E6DAE0BAB60D439
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DzFb41Z8Vz1y6k;
        Sun, 14 Mar 2021 16:08:16 -0700 (PDT)
Subject: Re: [PATCH v6] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210314225632.6759-1-jnewsome@torproject.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <31b4551e-38f8-a016-145d-4438990bdbc2@torproject.org>
Date:   Sun, 14 Mar 2021 18:08:15 -0500
MIME-Version: 1.0
In-Reply-To: <20210314225632.6759-1-jnewsome@torproject.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 17:56, Jim Newsome wrote:
> * Switched back to explicitly looking up by tgid and then pid.

Shoot, I seem to have dropped that somehow in my rebase-and-squash. v7
out shortly; sorry for the noise.


