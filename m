Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1173F3AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhHUOV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhHUOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:21:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5FC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:21:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so9133351pjv.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Vyw9fxWTiOhTDxiqjbBhpUmVvKmdQD+9QSsMdHpwzQ=;
        b=pDPb/x/7SdEBSQQKtRXScgHNOnUCFON7ozJGBQCEcUMmHNf6LB5zV2FofBIie25kZx
         mMBYkBrEGEBaS/qyryNIFOWkyxQZRTVPA1jlkKNT1FlkKkCBpXAYM6+XCraLW3VSO2Bl
         7v7YIXYSARnHjmKN1YyOQfAhY+I1LYagAnWRQgX9C75q6xsEBfB3F+BsFjH1K4WMOFdl
         y3gnxvKsSOy5dcsPg2BPQpQxemNjARQgAH+HsovBmtIGb3MHeB/g/GkJKGFPgH35kwnz
         sE7je0je6ZzS4ThdI+Zurn+Je53Tba3ndqCpFxUoDc5kwvlhxSDSA1T8I4z8Ba5sUGsg
         iCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Vyw9fxWTiOhTDxiqjbBhpUmVvKmdQD+9QSsMdHpwzQ=;
        b=gzCNNkMaUtNGsE+fAMniq7GdHcWz/jgp75HPJf/6KVxMEaITSdHfbY0VxDQsxXF6Cx
         NCZ3inafUYpEfuN4IeFV2qD9uKZgTDtLwySe8ZincMBHUedH1p4M5d96YL/iSh9g0HGH
         ueEJ2wEjLhkQWv4RIe1oalht3iEZZDQkhi4mTjM+PUzA39GykYRpHqxC2BJkj0B+ZSIm
         u6SlP2QP2RMZFwmG00v2LlF3TJBDsCYLJ4T1aiVTJKkycyxwotgIZqBmbpXVT0s1kBFy
         PCrum5AWn8UZ7c/Ks8RCL5oWh/adLqcNYHuLONZEUlMGC3lXm3SCAY3pQMI/8A7H8RZk
         3Sdg==
X-Gm-Message-State: AOAM531EgJSE9sYlOssjUfrlzMQ2s/bQekOCI8vJC5U8V3uH2UBTcj9v
        3CVC5eDtriZYCOj6ecM3qEE=
X-Google-Smtp-Source: ABdhPJwsmFy69f4DXdF1WOgto05mLEITK96V++62xAMrycMA90htD8PRNXJZWkEhXb/+AKj9TsDKFg==
X-Received: by 2002:a17:90a:4549:: with SMTP id r9mr10229611pjm.147.1629555678527;
        Sat, 21 Aug 2021 07:21:18 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id d13sm10314666pfn.136.2021.08.21.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 07:21:18 -0700 (PDT)
Date:   Sat, 21 Aug 2021 19:51:16 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210821142116.4febwhcnx4wjyprw@xps.yggdrasil>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
 <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 04:44PM, Larry Finger wrote:
> This patch is wrong. All the documentation I could find tells me that the
> multi-byte entries in dhcph are big-endian, thus the new line should read:
> 
> 					u32 cookie = be32_to_cpu(dhcph->cookie);
> combined with:
> 
> @@ -649,7 +650,7 @@ struct dhcpMessage {
>         u_int8_t chaddr[16];
>         u_int8_t sname[64];
>         u_int8_t file[128];
> -       u_int32_t cookie;
> +       __be32 cookie;
>         u_int8_t options[308]; /* 312 - cookie */
>  };
> 
> The old code was, in fact, correct, but not in a way that satisfied Sparse.
> 
> Larry

Thanks for the review Larry. I understand now, will rework and send it
through

Thanks,
Aakash Hemadri
