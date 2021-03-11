Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF2337F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCKUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhCKUxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:53:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F5E64F88;
        Thu, 11 Mar 2021 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615496013;
        bh=7+F5YOmiVHWy72rE2BwHNTWhC3V7Uq6bIKVOeUhYoQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d55qn5IJSDfqSdY5Ev8P8DdfItZjpJ2ohgaWjHVTtAg8pZXyvk8Sq5BMDW5eBET1X
         cRw9BzecB9KBDOobR6pU8WFCDL0Wf6xqtWWSqV63qTTz1P7mPbsDucvJgmXwHbiSnR
         ++0HkjojQuHBwWhf2MPNt3mOf6e0PnjdiI0ioSQM=
Date:   Thu, 11 Mar 2021 12:53:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe LeVeque <jolevequ@microsoft.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Eric Biederman <ebiederm@xmission.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guohan Lu <lguohan@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string
Message-Id: <20210311125332.0fb8b76b62afe90d3aa4686c@linux-foundation.org>
In-Reply-To: <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
        <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
        <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 18:14:19 +0000 Joe LeVeque <jolevequ@microsoft.com> wrote:

> Is this all your looking for? If not, please let me know.
> 
> > Signed-off-by: Joe LeVeque <jolevequ@microsoft.com>

Yes, thanks.
