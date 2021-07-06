Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78A3BDC63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGFRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGFRiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:38:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C7C061574;
        Tue,  6 Jul 2021 10:35:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hc16so35411054ejc.12;
        Tue, 06 Jul 2021 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzTl/84YKN02YpAuy0KqaRqKVDD2jRop8NkpUhp1Su4=;
        b=nBTP6+Lg0F+ps4zkUIrLODN5eB+Xg5+exkspQs0pM4g3HipT1hQxgSsmJjMz97+Dxl
         7zVX/JLkcWAy8Yss9rPZWJEhErmDqQMHrNVbvYK2CVSrslk0qSllF4SD7KY8rnpvG6/Q
         +fwllJGXE4RFrWaQolw4nW61e3tvokXWfpod3FSzvoC3xdIq60N8IJ25xoG+aly1Z6JD
         4SkqqngaEc7Ay0M44HTvzc1qr1/Vk6L3fMwp4F9uXup19KxS9Jkii1oaOQEzJUmFAEdJ
         eCvb35HFAIQQnKSlJk3nN0uTMsRUXex/KIkZiMjEXb41qBXhWtbv5eOwHCgoTH39wU3t
         plMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzTl/84YKN02YpAuy0KqaRqKVDD2jRop8NkpUhp1Su4=;
        b=JPDn3joAe6knrSyIHwAefIkAGcAQYfe6kO3GTs14EuJlydV26bJnhgUeAGbjoyBW20
         5Q8HL3rbPhGjACe8lDTPReGi20eAajF4vz4WwZNESNAM1YC2sXH+T8kY7vYjwMcp3Vnk
         zWVZJW4SvxqDz1wXz+mcx3OMdHoELXvg/exzThGtMdzTDk5vXoFhzBv9UtpCaen9RxgC
         io8MC1FfUEhpz8KqbQrLznLArFPSZ0rQ71vcNaoGSrUCggPTCs7ekXq5qDDwo9yWIUVv
         QuoNnG6hRpf6nMfVV4lnM8BjmXRLYkNx9LuK4zXo1YrLR01iGbUtBeqxnsWvJR9AvM+W
         yFdQ==
X-Gm-Message-State: AOAM532+QxO6heufjgeUa6opq4nTd977VW1uzRhzo4lxWm4c/+OW3EqL
        0Xw9IMbTcIZUwFcisBOiqdu3KNW+mCJ0VolqBf8=
X-Google-Smtp-Source: ABdhPJxMdUhnBmUkMeuKVgXzWFzoHuBNWhriV2UA3IQbKroOcsdBo9msapOY2k7XuE4F3cBAjySiTqC6UyNCZ9v6LLg=
X-Received: by 2002:a17:907:60d6:: with SMTP id hv22mr16725922ejc.80.1625592923424;
 Tue, 06 Jul 2021 10:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706161234.GA797557@bjorn-Precision-5520>
In-Reply-To: <20210706161234.GA797557@bjorn-Precision-5520>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 6 Jul 2021 10:35:11 -0700
Message-ID: <CAEdQ38HxsK+mvXWmxDbRMG_oKw7zPdaYnZ10f307771aBic8Gw@mail.gmail.com>
Subject: Re: add linux-alpha archives to lore.kernel.org?
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Eric Biederman <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 9:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Is there any interest in adding linux-alpha archives to
> lore.kernel.org?  See https://korg.docs.kernel.org/lore.html for
> details.

Yes, that would be nice!
