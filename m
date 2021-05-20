Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3638AE88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhETMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhETMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:40:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB7C04C3D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:55:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z4so6694339plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FssKbDFPY84FqxgRVczPOQqjaBhVLv/zqtosL172dAg=;
        b=Ozji9B7yvpIIIu5G7KIaK5nxYDL6KtsKb7UayXC0ku2+yWb86BDep+IyAO3Llj/WiS
         eDsolB/vooHciUlnNSx2KjS8u0H9ow6pUNXew+nE8jRfuzFsejV/Qsh0BUpTX9rVu4tx
         CtSPIGWq/dnguqy0H7oGb4aG0wdM+oNlAj3qiNUWL3I+tHE8/x3ynjJ7ddzVwRkPFXHq
         /5obJC6dXSbEyJ4WcBh8YT2hxZtoasYW8Kp/D2PCqBOOPEywsIXdtTssqXTBXgsxMClk
         KNM13psztzO2HrdKg7hYrvWcnxzKZDWFV6anMJuku1CObBqcS6rHxFKucTjmK91nOCFY
         XLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FssKbDFPY84FqxgRVczPOQqjaBhVLv/zqtosL172dAg=;
        b=ty9BEqhMTFKxDgvuk3UwUd3TvsZ8+ZI0xfhZJq0pXbl34bgvH915mghauLrLa/pf0G
         d8PwOexVh/NHQbjxb61veVqks4B8UoV8dbXGBr8lOZQ4V0MI5AnwrXyktJGJXr0pu485
         8Fxt44iaRUcusOtQmnZHNgrgBmY2EwbCjnGwj/XyFWJGzm/vMguCxkWIl1og7id188vF
         2Atfm5EDo2UoJ3cPLLEgGwz1+8Z4YMRp2DNoFYWPj2xMzAqfWOVcF0Ec16A3tyMHRgUN
         3mxRDG/vx50WE64UwgDWbbbhu7zaTYPdERZpRNSJ6Fx4tjgKGPOhDkaludb3L/Brq9eL
         L2Kg==
X-Gm-Message-State: AOAM533Yz0DeJ7BZ7m/tQsTUK+jyQwLQcwMwFoyyyoTV5YfeXQ1ptQvV
        T9kp2lml4DGZmImldxa4hzKuX2LkFk1oQD+dxmg9Ng==
X-Google-Smtp-Source: ABdhPJzZhJPDqB5Bu92WJSnbUI2ZhtvlXOs8/Jk5M3ss5oQPFYlNS1TEf+8BglgT/2Rg0R8wB000YuCnqz05Of3sKsY=
X-Received: by 2002:a17:902:8693:b029:f3:b47e:6a08 with SMTP id
 g19-20020a1709028693b02900f3b47e6a08mr5362284plo.69.1621511700665; Thu, 20
 May 2021 04:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-8-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-8-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 20 May 2021 13:54:49 +0200
Message-ID: <CAG3jFyt7vG4jQux76+g9r=ohJzhqBDE7g3A1LiwK_pUv2VBbzg@mail.gmail.com>
Subject: Re: [PATCH 07/17] media: camss: csid-170: support more than one lite vfe
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 20:08, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Change the IS_LITE condition so that it returns true for the second lite
> vfe found on titan 480 hardware (8250), which will have id == 3.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-170.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
> index 3958bacd7b97..af134ded241d 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-170.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
> @@ -21,7 +21,7 @@
>   * interface support. As a result of that it has an
>   * alternate register layout.
>   */
> -#define IS_LITE                (csid->id == 2 ? 1 : 0)
> +#define IS_LITE                (csid->id >= 2 ? 1 : 0)
>
>  #define CSID_HW_VERSION                0x0
>  #define                HW_VERSION_STEPPING     0

Reviewed-by: Robert Foss <robert.foss@linaro.org>
