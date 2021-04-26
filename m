Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0439D36B74D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhDZQ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQ4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3C09610FC;
        Mon, 26 Apr 2021 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456162;
        bh=N7vt9zftrYqQ9v5BBLSOwN6fk2XkSs+fz0f4XPtJeQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfIuqpGUiyGjHnSxfJLyfvOGlTj6PdUEmJV4LTXrdX1vjDDVV21YT6fNuyTbyDL3u
         S8TW/Zvc3A2kTDzhp0eek4xGRRcwQI428aODeGNnDadQU4nM8IciDYi4XcP+4bo2Rm
         IIgpuB4cg+GbmEYqJxxf1H0Tu/dR3vN8kV862K9c=
Date:   Mon, 26 Apr 2021 18:55:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 064/190] Revert "nfc: s3fwrn5: replace the assertion with
 a WARN_ON"
Message-ID: <YIbwn6D1EykhhMPJ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-65-gregkh@linuxfoundation.org>
 <9c2877c3-8077-c2e2-ed0d-80b2a0c87634@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2877c3-8077-c2e2-ed0d-80b2a0c87634@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:29:57AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit 615f22f58029aa747b12768985e7f91cd053daa2.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/nfc/s3fwrn5/firmware.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
> > index eb5d7a5beac7..f77f183c9bd0 100644
> > --- a/drivers/nfc/s3fwrn5/firmware.c
> > +++ b/drivers/nfc/s3fwrn5/firmware.c
> > @@ -492,10 +492,7 @@ int s3fwrn5_fw_recv_frame(struct nci_dev *ndev, struct sk_buff *skb)
> >  	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
> >  	struct s3fwrn5_fw_info *fw_info = &info->fw_info;
> >  
> > -	if (WARN_ON(fw_info->rsp)) {
> > -		kfree_skb(skb);
> > -		return -EINVAL;
> > -	}
> > +	BUG_ON(fw_info->rsp);
> 
> It took me some time to understand this but the original commit looks
> correct. The recv_frame functions s3fwrn5_recv_frame() or
> nci_recv_frame() should free the skb buffer on errors.  Here, the
> s3fwrn5_fw_recv_frame() should be called only after sending a FW msg and
> is expected to have fw_info->rsp=NULL. Otherwise it could mean that
> frame came twice or it came when we did not ask for it.
> 
> Original code looks good, please drop the revert.

Thanks for the review, I've dropped the revert now.

greg k-h
