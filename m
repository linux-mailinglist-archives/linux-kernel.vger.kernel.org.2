Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5363EF99A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhHREla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhHREl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:41:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CAEC061764;
        Tue, 17 Aug 2021 21:40:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 7so889205pfl.10;
        Tue, 17 Aug 2021 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXJ1UwoUafGWdyEPFBgwcthg6Cmm76oIXE3FODH1PR8=;
        b=tPsthpXVM6QKeMgDyvMcF9qdJ7A3Rz2cabPuvMqN94Z8Pg4oMB++3f1MOb/Asc9hjZ
         HdMYZ2OfhnL8ZJfDmTNlblPt6p86y9rhtVOCAKHRQQt/PBT0+MXH+NnAlrklwJxjbO1K
         MY//odu90EoA3NgptF2DNH1j3SWkvyod5YYHn+9CWCQ7ZwsNtw1jAzNEc1+Dt4VIpWXw
         rUdHnyvYfnGTwZrP/K7vBQveD5gosX0ZEVQD7/AD+vtYNy5CCmNwbROq/dQKc+4Lu9Hd
         YFSuOX+wUYv3dc9IpLtoqJ6DPBz8GW9r8ZZXXSAIGqy/ykWvbuyp4vHjEZqEQDQZGPjd
         3NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXJ1UwoUafGWdyEPFBgwcthg6Cmm76oIXE3FODH1PR8=;
        b=jAC7TWV/eEDFY+isBq71FmwXKbgjImJxajFYuCRgKmdKUkY3z69m1jqGRh8b6l7of5
         uRFyHlNNRKU/BDdaNgs6Rvyk/EhC5QC1moP0IjuWItnH6JfF/UPUQKwq1lyyNDjrV8uc
         E5RO9v1OT4Xsj5IgktUOJHyk1cXC5SuwQ4jlxmJXtIuFMOTPvdQ/zFnGkHETy1KxThx6
         YIIE6qzlxrvVw6xXIFXg0uAmnYhCMutLiJipM0GRJ+2t//iF49nsxVR0kNRGk6yEU/Oa
         hTI7X9doicgSizWxpnfFuKlf5t6e8y5lDwzayS/fsrJbI+LIuRacbVn6CR9tuoQkEBbd
         Og5w==
X-Gm-Message-State: AOAM5300ogtTHW9Gs7neDWz8mi6x+Jpw1su6NjDn3+P6qOVDl2fPmoGP
        WORDSEbViOokcJoJO+ipwtedrfSkRthaOw==
X-Google-Smtp-Source: ABdhPJxAHuJ7ZjRkJKN/NQrwe/QTixF7o3XfUIQ5ckUVvVA1ZnGUjUcwKfSKSNBVUJAHcyR3Y+npuw==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id e6-20020aa782460000b029039a1e0acd48mr7305561pfn.14.1629261653438;
        Tue, 17 Aug 2021 21:40:53 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id k4sm4280950pff.12.2021.08.17.21.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:40:52 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:10:49 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Message-ID: <20210818044049.yd7tnjvj3j4j3ddb@xps.yggdrasil>
References: <cover.1629134725.git.aakashhemadri123@gmail.com>
 <YRv3w4y3r84mBjrU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRv3w4y3r84mBjrU@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/17 07:54PM, Greg Kroah-Hartman wrote:
> This series does not apply to my tree at all.  Please fix up and rebase
> and resubmit, after reading the mailing list archives for others that
> have attempted do do this type of work in the past for this issue.
> 
> It is not a trivial change that is needed...

Will check what went wrong, and see what I can do.

Thanks,
Aakash Hemadri
