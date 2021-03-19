Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0729C341456
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhCSEoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhCSEnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:43:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E80C06174A;
        Thu, 18 Mar 2021 21:43:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w11so2374968ply.6;
        Thu, 18 Mar 2021 21:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CTgHdYOzEQOfuhJFVremO7lHiZ8opI+WNbUkwDbHd+c=;
        b=edr48RkqaLDb5EKkUp/3HOdo5Ed7hPa2nx2FatmOAwXBxoBpxtN5GnACALd02UssSz
         XGw4RdF4jGK+XDmPA9xKerRF0MMW7CRCbCxM2RCjz+RRMDnTfa4zLmziB2IOFyw5lra3
         uzsygeypk6+Oos9JJHcyndtSSM5yRY3GBOEtIRNh8NfbvqAzYAMtuxbBQW+8H6QMzIY2
         rI7ot2fWunuZzHlKuDjKgp/wFmm5Jd0grI/bpAehFnfb2WpCAk2nDmu+7/sG/JFB4AKH
         rR+/mSApDOZs0V/YTG8YV/J9aZ98WQhFoi0pTBmttVZZEOCDvlrQ8FLGQC5bfUo4ak2b
         xYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CTgHdYOzEQOfuhJFVremO7lHiZ8opI+WNbUkwDbHd+c=;
        b=iMzTiEHACthCfRRgRpP7J6He4ebczdGMO8AGKQFxV35j0fNX9wkLC6k0MWF2TwgQjx
         D2b9Kvi4EPZM1MqMq5rNngW7Dq88qyhB7Jkr7ReC8xx+MFsoiVrNdEgyrOD9Rwd8GY1S
         31JdyDExr0z3ajNb37sLcuc/K4qSlAQmCH4DQeYjQ/8U0oByQnJeNgRfklYAJVSxEbp1
         CUzMWquGSM+sk4xuSzobKxMbwqQwdW9984WTq8Z5TxvL5P0/dx3DXI8Hp+enn4QRnI6R
         qsb1JOCFZ//3yjmoM7jmDWD48e+FpCh13gZP1OVuGZTZhth8FLUpVdansuqy/e4IlReX
         cFIg==
X-Gm-Message-State: AOAM531XagT5JWkzkjaIQW2uySvAFhGqDo8RaTnPj/fxTOtYFHexDOgP
        rBLaZW55ikETa4TTjJTwx+Q=
X-Google-Smtp-Source: ABdhPJyq+oMDRY3fpFEvBNc+HBBtyxk1/YZlVMBahdJjI/X0exvJLvw2oi2z5vLAu3Q+Z7XzvOVp7g==
X-Received: by 2002:a17:902:d647:b029:e6:1ef0:8278 with SMTP id y7-20020a170902d647b02900e61ef08278mr13059759plh.57.1616129027168;
        Thu, 18 Mar 2021 21:43:47 -0700 (PDT)
Received: from jagdpanzerIV.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j35sm3805306pgj.45.2021.03.18.21.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:43:46 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:43:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH RESEND] cifsd: fix a IS_ERR() vs NULL bug
Message-ID: <YFQr/W2jLEJBnUXy@jagdpanzerIV.localdomain>
References: <20210318131152.GB21246@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318131152.GB21246@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/18 16:11), Dan Carpenter wrote:
> 
> The smb_direct_alloc_sendmsg() function never returns NULL, it only
> returns error pointers so the check needs to be updated.
> 
> Fixes: cabcebc31de4 ("cifsd: introduce SMB3 kernel server")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
