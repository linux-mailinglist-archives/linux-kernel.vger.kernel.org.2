Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79B3F6148
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhHXPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbhHXPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:07:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF8DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:07:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s25so19505041edw.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hULPFAkyAPdS/vngzljMkYnL+FEm5rIj4ZI5jqPlpo=;
        b=EQMJ6qdHjnSDnKUPsqFMI4lpIr9Q9caVjs/72KugI9xSH+BHi/jHdSbMCsgPIBrEel
         TCAtD6YIH6ZvJ33I5Ni2ctlyYq3AxXcBvO/XjBRQk9sTwK+RfM2BIJkSkyYm/9tMY7lW
         kreBho9k+nyZjW64sCqq6IVidV3QuSTFjuotJrC+6KykAsQQpGw+ThHRQXrYgOarCstK
         r/ZF8WnylnD2H7sZGLSAOYFu/Kankea2T8qNGRoboy2ZAww3ALoN8nHH7RE+7d4qV4h8
         BkFXKj6xGDM+kIabXDEgUxZT2XzC6b182ilrNMzhmfpMIsEvFVKpHWpB4SUS4vNWgt0v
         FUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hULPFAkyAPdS/vngzljMkYnL+FEm5rIj4ZI5jqPlpo=;
        b=geOWWlHc7W+OszkW2NWNORg04HUu2e2nrkdibD6SZhHMM2az9jKFO3nLO2kD9w0gZT
         XRvAOOwhJXugS/8+cTjmQxEyU5WyXyOipgc3YiFJu8DmxKa+ru/wUqwwd6o22fJqIybc
         GxOa4MxzbWEEIKrl6uO4DYiY4j/hUDkpNG3JVWrahOvV6yMCJDT6n/vUFR3MGvcJ5A5G
         idhePhFptx0aOo903ea31oEKuynmouJE+QC0pKBtdZkQK4aBLvaKGFj2zNIPqy4nhUAn
         lv5j5+6GcdaOvhGRDE6KCyLsWxsJVQMNJulqIls/D6dStBoyOd9Ug1WLHmGEaKHNNalL
         vs/A==
X-Gm-Message-State: AOAM532D1e/pprm68G+lyuCBMLclLx/zz8oC+/EhmV588OTztmsZkOMV
        ttnZMQQiy7zMbMJru5zI2Cs=
X-Google-Smtp-Source: ABdhPJyumdBm7YK5jEmH4azn80w0E4VFSOF6bI5Lr3EDch3FLSi1/EZ8WpwYJMRTTUvcNcJKuDLZTQ==
X-Received: by 2002:a05:6402:8ce:: with SMTP id d14mr43765546edz.228.1629817624076;
        Tue, 24 Aug 2021 08:07:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n23sm11971876eds.41.2021.08.24.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:07:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
Date:   Tue, 24 Aug 2021 17:07:02 +0200
Message-ID: <1655559.bbUi69aIZD@localhost.localdomain>
In-Reply-To: <e50d266f-410c-34cb-e28f-f27dc429ef37@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com> <20210824065825.GL1931@kadam> <e50d266f-410c-34cb-e28f-f27dc429ef37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 9:01:23 AM CEST Pavel Skripkin wrote:
> On 8/24/21 9:58 AM, Dan Carpenter wrote:
> > On Sun, Aug 22, 2021 at 05:36:01PM +0300, Pavel Skripkin wrote:
> >> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> >> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
> >>  {
> >>  	u8 requesttype;
> >>  	u16 wvalue;
> >>  	u16 len;
> >> -	__le32 data;
> >> +	int res;
> >> +	__le32 tmp;
> >> +
> >> +	if (WARN_ON(unlikely(!data)))
> >> +		return -EINVAL;
> >>  
> >>  	requesttype = 0x01;/* read_in */
> >>  
> >>  	wvalue = (u16)(addr & 0x0000ffff);
> >>  	len = 4;
> >>  
> >> -	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >> +	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> >> +	if (res < 0) {
> >> +		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> > 
> > Add a return here.  Try to keep the success path and the failure path
> > as separate as possible.  Try to keep the success path indented at one
> > tab so the code looks like this:
> > 
> > 	success();
> > 	success();
> > 	if (fail)
> > 		handle_failure();
> > 	success();
> > 	success();
> > 
> > Try to deal with exceptions as quickly as possible so that the reader
> > has less to remember.
> > 
> >> +	} else {
> >> +		/* Noone cares about positive return value */
> > 
> > Ugh...  That's unfortunate.  We should actually care.  The
> > usbctrl_vendorreq() has an information leak where it copies len (4)
> > bytes of data even if usb_control_msg() is not able to read len bytes.
> > 
> > The best fix would be to remove the information leak and make
> > usbctrl_vendorreq() return zero on success.  In other words something
> > like:
> > 
> > 	status = usb_control_msg();
> > 	if (status < 0)
> > 		return status;
> > 	if (status != len)
> > 		return -EIO;
> > 	status = 0;
> > 
> 
> I see, thank you for reviewing, will fix in v3! I fully forgot, that 
> usb_control_msg() can receive only part of the message :)

With the use of the new API I think that you don't have anymore
partial messages. usb_control_msg() returns the number of bytes 
transferred, while usb_control_msg_recv/send return only 0 if successful
otherwise a negative error number.

Regards,

Fabio

> With regards,
> Pavel Skripkin
> 




