Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC0369090
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhDWKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:48:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36448 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbhDWKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:48:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E9AFC1F43A37
Subject: Re: [PATCH 025/190] Revert "platform/chrome: cros_ec_ishtp: Fix a
 double-unlock issue"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Mathew King <mathewk@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-26-gregkh@linuxfoundation.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8825f20c-7e58-c44e-fa7a-bca811add5a1@collabora.com>
Date:   Fri, 23 Apr 2021 12:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-26-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Many thanks for the patchset and notice us to take attention about these patches.

On 21/4/21 14:58, Greg Kroah-Hartman wrote:
> This reverts commit aaa3cbbac326c95308e315f1ab964a3369c4d07d.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Mathew King <mathewk@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I've reviewed the patch again (also double checked with people involved in this
driver) and I don't spot an obvious issue with the original patch. Without it,
on error path, the read-write sempahore used, will be released without having
held it before.

So it's IMO a valid fix that would have to be done the same way after
revert.

Please don't revert it.

Thanks,
 Enric


> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index f00107017318..d4f41d68232c 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -677,10 +677,8 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
>  
>  	/* Register croc_ec_dev mfd */
>  	rv = cros_ec_dev_init(client_data);
> -	if (rv) {
> -		down_write(&init_lock);
> +	if (rv)
>  		goto end_cros_ec_dev_init_error;
> -	}
>  
>  	return 0;
>  
> 
