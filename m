Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942323FF2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhIBRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhIBRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:47:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B7C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:46:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2018478pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vqm/Vjt4OCbk8aFeOwhlPn2yk9OwMuTw1Seb9Qgfvbk=;
        b=h+EKOsNgJWJs9df0lXbdA5YdsUggg9hoOPZ9IX4LJXNPKaiiopLy9sSXY5EbFl8niG
         eWXlEuna7Dthtq+J97MOYQOYpfAomC7EiNDe2u1KuGDDKG269YyM+nHmgV4OuWcVl9/H
         JYYqysXKJGVAe8d7utetpxXdB3/fF1UOarKKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vqm/Vjt4OCbk8aFeOwhlPn2yk9OwMuTw1Seb9Qgfvbk=;
        b=o85v/4WKvaoCXvDIP0wE6b9OebOwJjIngSm9pnYq+lDOyvQ6IECAfCeYxnJfB5Ysbq
         qQLJD3S221P1D8jqNotkNHSEeVDACM8tH3anwGspxr2WfJwIqqFeD0hCeLdkTzTQQrL5
         3ALzM1ks5Tzx4chIkI0vhxB3tCWecX19gTlyCQWHPMb5WTypLn2N4g1RDS38Ib1+G3Hz
         Z9QMyYI/X7UCC82VyYq9vSyfbjBWbEh6+Shy7AgZLcYaf2C52wij/eRf8ygH/Iw7F8Y9
         iwX8R6L7kVb8aV2G9GY2+fkPe1lFLBP8unuN4KWf960bD5LVJF7Bp9ANZ9rzSM5gYAAM
         dudw==
X-Gm-Message-State: AOAM5314GKgSpIoVDAmUV7zHEEL7tubo+LF/7m4K/e6UORvHKmrIYzzU
        lRwbGK8PDNGOz0Ex2KyI4+K3iA==
X-Google-Smtp-Source: ABdhPJzFUUrP+wjw1or2yo13Ci1xUdabM7U1PlsBbO2VMPR4hRY993GeNttEsdAlSGeWW27cZJD9Ew==
X-Received: by 2002:a17:902:b691:b029:12d:2b6:d116 with SMTP id c17-20020a170902b691b029012d02b6d116mr4019656pls.71.1630604802020;
        Thu, 02 Sep 2021 10:46:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:76ac:d178:a633:4fb5])
        by smtp.gmail.com with UTF8SMTPSA id 26sm4039624pgx.72.2021.09.02.10.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 10:46:41 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:46:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v7] Bluetooth: btusb: Add support using different nvm for
 variant WCN6855 controller
Message-ID: <YTEOAJgihvuXLcpa@google.com>
References: <1630572986-30786-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1630572986-30786-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 04:56:26PM +0800, Zijun Hu wrote:
> From: Tim Jiang <tjiang@codeaurora.org>
> 
> the RF perfermence of wcn6855 soc chip from different foundries will be
> difference, so we should use different nvm to configure them.
> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>

as I commented before on v4:

> Please also add your own Signed-off-by tag, even when sending unmodified
> patches on behalf of others. In this case you are making changes to the
> original patch and are effectively a co-author, which is another important
> reason for adding the tag.
