Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F441DD84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbhI3Pd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbhI3Pd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:33:28 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:31:45 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id h132so3048718vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMQZgqn6m+291rbD6FB65yGqtk2LWYklc58PG7BawH4=;
        b=WeP91qmSgIXo1a/NFgp0fBJwwk/RQsIG6P3TGJEJBiYShkWapc/jobvYucjLJrBsuA
         h2EV+zHcjy+Soh6Mfth9AW7mPPHQ+dx6X/FIFhiwhByHduZCcwZlwRyHztCr0gRmYYCR
         Jn6XleEH08+3mv3q5L/ISO8/LIcjqsd6NXmpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMQZgqn6m+291rbD6FB65yGqtk2LWYklc58PG7BawH4=;
        b=Gs9Etsb6rkZsw9I3o1yGEn8e5GfW5aaqfBsAfZYa6bjXvn1Ge2V9Nexo0ePqRhp32k
         81UU2blcOvo/M6wqIAkvAJLcq5u3UwgDBqUDokSwUIJ4DfOJdTpObvqIkopUI7GJ7+cF
         Kl+tE8uyZ/OQQxpfCR79HKJldhZV6HzGjLhxvx9gcaJdOnu/GznpZXKaN2GY7n0TXgcP
         gQLC+u4KA8efTXAl+gtuoCJ7BdWo4ch8g4kjJCdI9D7LhKna9CcE5OoXYyR2/c6Vkobi
         ky3T1fqwb1nPAhhziZuqNHQdzdW9GW/Rn3LS8DHUWkrZSQthku0nMG7CrKGq+/FHeABw
         g3EQ==
X-Gm-Message-State: AOAM532VjlWwbTYT9E0fMweMQpJ2y9Vt/HEfdU9wIIZd85aQ2goTipyP
        1PvJseSXu+kokFrc+UjKh9EmoW/IwibI0JbBrsUtEg==
X-Google-Smtp-Source: ABdhPJz5wnisH1ZAkrMyUoL5nwJGU72PDXvYsb979G+ivugO/mU+8liTpY1eHMQRJC1nHk6kOkqZL8h0N58DRETHcBY=
X-Received: by 2002:a1f:f203:: with SMTP id q3mr3893652vkh.1.1633015904635;
 Thu, 30 Sep 2021 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930124950.3069638-1-daniel@0x0f.com> <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
In-Reply-To: <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 1 Oct 2021 00:31:34 +0900
Message-ID: <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 1 Oct 2021 at 00:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> And incorrect fix. See my patches regarding to the topic
> (`git log --grep ACPI_PTR`) and do accordingly, i.e. drop
> ACPI_PTR() for good.

Something like 349bff48ae0f5f8aa2075d0bdc2091a30bd634f6?

Doesn't this mean the ACPI table ends up in kernels that will never use ACPI?

Cheers,

Daniel
