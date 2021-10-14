Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7F42E0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhJNSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhJNSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:08:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:06:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so29757380lfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsRlgBJbQTA7BY0Fnmwq5m4pEEvG0cBSI6R143Kt50g=;
        b=WHV2vCMXGD6ZEvIfni8By8V/L+NEVj2+siSM5i6u+m+m4A17VkxISTcczENL7HggIW
         TsQGqR/AEE81Vj7fIIUQEtBL8pqP9Ix0GDfdKtzZ8o1/bQe0eD1VLhGODIpw2Jq4hNax
         Q8Bvf1oqUvYqc5igH+QmEvrzuqFfdGsS0B0qJRgXZA9YD81Ci1am6yNTzRop5IcA8498
         ohgRnARPE0aZDMYbAyiD0Dg84i3YCw1jEVx3eGvaOjRQHbQtP1uvn12BQ6ngMqBruA0p
         wr++gQ/NF+pYW4KMY+M0Vx3qXUgmvERGya7NWl1VwPlYukhdz62g5fmNj20IpFQtlWoR
         BQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsRlgBJbQTA7BY0Fnmwq5m4pEEvG0cBSI6R143Kt50g=;
        b=6ccvNpt1sx22Wq5T6c0yQQThjNoJU6qne3fF383Ot8YhrApf/I0XQAPfb8HT9KWhhc
         aUzxa5Tlgd7zLw1Qq5SyY80VHOMEOVd60zK4nP9+EkGPuMm0mtF91k2KLI+EeeIS/pRV
         dLznnTc5KbNMA8HneDtYTShF3w4T8CfJT4eg3wI2KAf2PImrWG4SsVifz8EdWd8mPop8
         uB7w8uGvNuiwCJP1M/FhiUrea8GnpxbeZQ8WrOOwa7eq+1ZF9+UafbNB4u01O+vVhe47
         k37lNlN/3POlAQ73v2R+xkOEBECbYzUF4ybtLgP5MldeVkn7yivLFoFl9aeQVzI67+II
         Zubg==
X-Gm-Message-State: AOAM530RxxhRDNpO4AapwDFCX6OuIc23w6S809O+wCGrS2afqYLJnMAu
        PbE7ah1+pX9wcj4CwZuTKWb/sopByWXzNubT8fGFfA==
X-Google-Smtp-Source: ABdhPJwETpROOF2rrrefiOfmhu3BX0ABuQ/67vQm8aEmvHnaIzANh2CeoTXlhoqCmEo5ip5J+Zo0EKES+Y5LLFtNL+I=
X-Received: by 2002:a05:6512:b0c:: with SMTP id w12mr6667968lfu.240.1634234807558;
 Thu, 14 Oct 2021 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211014150610.GA22151@kernel.org>
In-Reply-To: <20211014150610.GA22151@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 11:06:36 -0700
Message-ID: <CAKwvOdmHPR-9wB-aD-8P=w74W7RKfvOL-VcDVy=8TWHGb_brfw@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: remove GCC 5.1 mention
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:06 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> GCC 5.1 is now the minimum version.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler_attributes.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index e6ec63403965..87d1e773400c 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -104,7 +104,6 @@
>  #define __deprecated
>
>  /*
> - * Optional: only supported since gcc >= 5.1
>   * Optional: not supported by clang
>   * Optional: not supported by icc
>   *
> --
> 2.33.1
>


-- 
Thanks,
~Nick Desaulniers
