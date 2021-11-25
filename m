Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87645DCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhKYPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232761AbhKYPIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:08:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00A9661038;
        Thu, 25 Nov 2021 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637852744;
        bh=4/XxSKbDN99TrKGrzYnMW2/tjTV3XTjDVg3jBYTrSX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tYPmRntiPCK//9nEVNcwh8rDOYcofvDC6nOa5hrSic8IHZJNwjFJ+XdNkjVYTTE68
         8QCCme37ZtMSYbpBVPd9dLswD8iIjFCIBCyXAE66I/tSuWIkKavRAHambjE0mVQvsJ
         79WzFq3QpzW38EwwJ5gkVzU06i5CjxJHLfRto8y5FpFD5Ri8fILjI/0GJWpAEcDycC
         GZMVEDn2SSGzYWpjDkBjp8NjNXTIqxaWf2zQpL7pzmyPTj4gCRCUCtSA9iOCl3ufdP
         9pQ6QvXXGRn8hmsJgZ67DgfUTiL/+vvj85euSTMre9y0lJF7YMHb+HW4UD3yUu/Y3u
         4jiY0yq8TgIFQ==
Date:   Thu, 25 Nov 2021 07:05:43 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     andrew.manley@sealingtech.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: fix oob access due to uninit smi_msg type
Message-ID: <20211125070543.7d3225af@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211125142140.GV15676@minyard.net>
References: <20211124210323.1950976-1-kuba@kernel.org>
        <20211125142140.GV15676@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 08:21:40 -0600 Corey Minyard wrote:
> On Wed, Nov 24, 2021 at 01:03:23PM -0800, Jakub Kicinski wrote:
> > We're hitting OOB accesses in handle_ipmb_direct_rcv_rsp() (memcpy of
> > size -1) after user space generates a message. Looks like the message
> > is incorrectly assumed to be of the new IPMB type, because type is never
> > set and message is allocated with kmalloc() not kzalloc().
> > 
> > Fixes: 059747c245f0 ("ipmi: Add support for IPMB direct messages")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> This is correct, and in my queue.  Thanks for the fix.

Where is your queue, BTW? I see not T entry in MAINTAINERS and nothing
of note in the github tree from which you send PRs.
