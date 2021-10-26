Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5743B792
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhJZQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhJZQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:52:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9807C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:50:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b12so14137518qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wERXcRAQ/I//djLVS+exIHaSTMibkMB6iC5nNkVNg9E=;
        b=Ys6OqEsUFnubgTs3A45NkfIy1d3Osj2cXDYYiwJRPjNovs39ZFHCkKwqRY8LuRbjDW
         B7JFj4j+ggpykOgO5q4JtCApWYjipzJOndmZBjkE7IPkjmji/A1QchKW/jWeQrxfaShf
         TzWsCh8DNBx+GzQ0m2rwU66vz0bAIknVsygPxNH76F/LOm96kJ5vmYUBWgpwbgyaV6Ue
         oe8wcnJZiUOktP5yjuFxp8QGc972QlM711cvKTm8eS3axB/4r4b3e9gKBqME6SpDEluP
         IB/nptRnUFOG9sxZB5L3kEI2y/zHku0GOM/5ihe/W0pwgMMWMOVN+2jf17KxapxVte6T
         ScUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wERXcRAQ/I//djLVS+exIHaSTMibkMB6iC5nNkVNg9E=;
        b=kEQ1GEQiq6V2RngXhJwLd6VZaGKKuYRJG6+vtCQ6goMKD6xaG9nVp8WHKcytriwv9U
         Bsrxm7oLLeDntLCJWJpbGoGpik5paUUEpON+BdkMUnj2BotxujTYL2XD9OLwCplLjDcr
         cgLaIheKBRNjPzVmoCDhNqfHqpsbi2GgDQaUH8d2vm04wf6r2W0SEl28JFD7nrVeBgW3
         nF5FWI4HiGBfYx1Ii9zcLGtS05vMsZSUJwNPX6Htk+EAjjeQJ+Zx51CAkuVgXdYS+gX5
         HXYOMxX+3fZ30prAjI4dG0eVpyKPn39edpbaeuvg+ogFve62n/vE8WqyTKyxF8mSXrBR
         YEzQ==
X-Gm-Message-State: AOAM530Ihg3nc3WnKwoq+GHwUpNS3LQE450QIe+UgpJFBrtv6Lv4DrXK
        tbhBF/qEqLLCc2nCfZe/kl2+1SOhkQ==
X-Google-Smtp-Source: ABdhPJwpl6zcPrsn0PotBJMlEXnjRTbMzCIc7iIUCnGSxC56T/JU6yCg8Fvbtpf0Iv5e9CnjgRsehA==
X-Received: by 2002:a05:622a:83:: with SMTP id o3mr26312912qtw.17.1635267011819;
        Tue, 26 Oct 2021 09:50:11 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id c8sm11288834qtb.29.2021.10.26.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 09:50:11 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ad7f:7a7f:3b9a:4eab])
        by serve.minyard.net (Postfix) with ESMTPSA id 4C6B91800B4;
        Tue, 26 Oct 2021 16:50:10 +0000 (UTC)
Date:   Tue, 26 Oct 2021 11:50:09 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kunkun Li <likunkun@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: ssif: Add msleep in multipart test
Message-ID: <20211026165009.GD2744412@minyard.net>
Reply-To: minyard@acm.org
References: <20211026025834.82766-1-likunkun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211026025834.82766-1-likunkun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:58:34AM +0800, Kunkun Li wrote:
> During multipart test, cmd(6,7,8) or cmd(6,7,7) will
> be sent continuously.

This is not useful information, we don't have access to your tests, so
this is meaningless to us.

> 
> The pressure test found some BMC systems cannot process
> messages in time, resulting in read_response continues to receive
> error messages from i2c.
> Retry mechanism will takes 10s, and finally set not support
> multipart transmit.
> 
> So, to work around this，add msleep after sending cmd 6 and
> cmd 7 respectively. The problem did not appear again in
> pressure test.

No, you can't slow down everyone because you have one dodgy BMC.  You
need to detect that this is a BMC that has the problem and only do it
for those BMCs.

-corey

> 
> Signed-off-by: Kunkun Li <likunkun@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 20d5af92966d..65841798fafe 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1453,6 +1453,7 @@ static int start_multipart_test(struct i2c_client *client,
>  	ret = i2c_smbus_write_block_data(client,
>  					 SSIF_IPMI_MULTI_PART_REQUEST_START,
>  					 32, msg);
> +	msleep(SSIF_MSG_MSEC);
>  	if (ret) {
>  		retry_cnt--;
>  		if (retry_cnt > 0)
> @@ -1467,6 +1468,7 @@ static int start_multipart_test(struct i2c_client *client,
>  	ret = i2c_smbus_write_block_data(client,
>  					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
>  					 32, msg + 32);
> +	msleep(SSIF_MSG_MSEC);
>  	if (ret) {
>  		dev_err(&client->dev, "Could not write multi-part middle, though the BMC said it could handle it.  Just limit sends to one part.\n");
>  		return ret;
> -- 
> 2.11.0
> 
