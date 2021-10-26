Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1243BBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhJZUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbhJZUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:50:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3005C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:48:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bk35so387075qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=voIqEXStO2bmGabwFowsT3t9DeTHiN7x8iO2F0Skzmw=;
        b=g9ubPdUDessLkR2PqedKr0pQ4aUQgAtx5gvLK8WOaxAAt3BQQw1PKZulTbmK5V/+/e
         fzk1NlrhQ/URYFzgoz99AOYHOMuj4YtEFT+MIe7ypVaarEafXgGJFNkkE0czBug+8wSc
         9o5w1C6CVS0hWkqYcmxSrL+scz0NsmfOwkjJ2h+uaMLv4Qq0gVdmdiNWQuJv3QZ3bkL+
         0fCHEBtlLtg1ppZ5V+lVzGpllJ93tsKCG8s48fS9rMY/LUsWw6CZ/hy1OldlMStjthnP
         oVS4e2v0BZSubq3Hg1Dvsf/2fr7RZF1rZ14KGlW8oT1OGA2GOO81D9M9jFVZPfTkmlOy
         3X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=voIqEXStO2bmGabwFowsT3t9DeTHiN7x8iO2F0Skzmw=;
        b=bNaujLLx8+p0GDkzSXqtlVL85T6dX53pbJGDCFsqf0BJcf4qRPDWmF9vBKxN52nEx9
         SQZ3v7yUVuxW0MI+eG6ppWOVr++8rrD4Y4Zm8EBirzxIx2dTNOQvPIGga5OWwqq8SW0m
         ibJw0dckJCfedulUQwhbKkwfBMTX0VOBUyN/4tbZ7UPxC0cx86pGpuIYqMEFKREQ1rkW
         Q7StQOU2T5HoVdP3/sQLjGsSWG/bEiR+21LysukY7PXClqWhoo1CGoUfhj6rrwanMOYX
         i7uLIg4Iij5C8iOdTj92YYmuyg4mP7bjT9vuGKdrsncF4f/Th9SGazPb4UHQfPVs491j
         bddg==
X-Gm-Message-State: AOAM53130IbdkObrZLGFwn6XQaPNVHvJ+tMXduUaJGjG0mCuBHJqrxUz
        SzHNwC0wObUOZa15RSvdE2TKwZF4hA==
X-Google-Smtp-Source: ABdhPJwt+cQAJk64r9oApemgKBsrqBauo21AwRAPt5vOO60lnmzjcyhXcb91oh8JY+E2PIBzinyI2Q==
X-Received: by 2002:a37:a050:: with SMTP id j77mr21608934qke.337.1635281283839;
        Tue, 26 Oct 2021 13:48:03 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id o14sm12565768qtv.91.2021.10.26.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:48:03 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ece2:c5c7:8266:ec0b])
        by serve.minyard.net (Postfix) with ESMTPSA id EE5191800B9;
        Tue, 26 Oct 2021 20:48:01 +0000 (UTC)
Date:   Tue, 26 Oct 2021 15:48:00 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kunkun Li <likunkun@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi: ssif: Add msleep in multipart
 test
Message-ID: <20211026204800.GE2744412@minyard.net>
Reply-To: minyard@acm.org
References: <20211026025834.82766-1-likunkun@bytedance.com>
 <20211026165009.GD2744412@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211026165009.GD2744412@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:50:09AM -0500, Corey Minyard wrote:
> On Tue, Oct 26, 2021 at 10:58:34AM +0800, Kunkun Li wrote:
> > During multipart test, cmd(6,7,8) or cmd(6,7,7) will
> > be sent continuously.
> 
> This is not useful information, we don't have access to your tests, so
> this is meaningless to us.

I realized what you meant above.  The "multipart test" is what the ssif
driver does to detect multipart message support.

My suggestion would be to use the results of get device id (manufacturer
and product id) and compare it against a list of of BMCs that behave
badly when the multipart test is done against them.  Then just skip that
test for those BMCs.

I know that adding 40ms to the detection doesn't seem like much, but
every little bit matters here.  It doesn't take a lot of those to really
add up.

-corey

> 
> > 
> > The pressure test found some BMC systems cannot process
> > messages in time, resulting in read_response continues to receive
> > error messages from i2c.
> > Retry mechanism will takes 10s, and finally set not support
> > multipart transmit.
> > 
> > So, to work around this，add msleep after sending cmd 6 and
> > cmd 7 respectively. The problem did not appear again in
> > pressure test.
> 
> No, you can't slow down everyone because you have one dodgy BMC.  You
> need to detect that this is a BMC that has the problem and only do it
> for those BMCs.
> 
> -corey
> 
> > 
> > Signed-off-by: Kunkun Li <likunkun@bytedance.com>
> > ---
> >  drivers/char/ipmi/ipmi_ssif.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> > index 20d5af92966d..65841798fafe 100644
> > --- a/drivers/char/ipmi/ipmi_ssif.c
> > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > @@ -1453,6 +1453,7 @@ static int start_multipart_test(struct i2c_client *client,
> >  	ret = i2c_smbus_write_block_data(client,
> >  					 SSIF_IPMI_MULTI_PART_REQUEST_START,
> >  					 32, msg);
> > +	msleep(SSIF_MSG_MSEC);
> >  	if (ret) {
> >  		retry_cnt--;
> >  		if (retry_cnt > 0)
> > @@ -1467,6 +1468,7 @@ static int start_multipart_test(struct i2c_client *client,
> >  	ret = i2c_smbus_write_block_data(client,
> >  					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
> >  					 32, msg + 32);
> > +	msleep(SSIF_MSG_MSEC);
> >  	if (ret) {
> >  		dev_err(&client->dev, "Could not write multi-part middle, though the BMC said it could handle it.  Just limit sends to one part.\n");
> >  		return ret;
> > -- 
> > 2.11.0
> > 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
