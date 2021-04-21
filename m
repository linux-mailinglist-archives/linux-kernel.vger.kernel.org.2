Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE1366E35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbhDUO3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:29:25 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51975 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238173AbhDUO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:29:24 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 13LESVGi006924;
        Wed, 21 Apr 2021 16:28:31 +0200
Date:   Wed, 21 Apr 2021 16:28:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 142/190] Revert "rtc: hym8563: fix a missing check of
 block data read"
Message-ID: <20210421142831.GB6631@1wt.eu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-143-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-143-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:17PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 9a20b5e35a536d6bb4b2d4a3b14a0457e205356c.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/rtc/rtc-hym8563.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index 0751cae27285..a9d033eff61e 100644
> --- a/drivers/rtc/rtc-hym8563.c
> +++ b/drivers/rtc/rtc-hym8563.c
> @@ -94,8 +94,6 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	int ret;
>  
>  	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
> -	if (ret < 0)
> -		return ret;
>  
>  	if (buf[0] & HYM8563_SEC_VL) {
>  		dev_warn(&client->dev,

Seems like this one was a valid fix, and that the description matched
what was done; plenty of other drivers also proceed similarly. I suspect
it should be kept.

Willy
