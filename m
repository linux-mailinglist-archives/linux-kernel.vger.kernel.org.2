Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E83E104C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhHEIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhHEIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:30:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84104C061765;
        Thu,  5 Aug 2021 01:30:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so13044578pjs.0;
        Thu, 05 Aug 2021 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YItJSibc+CAMFtQEZMwaq2dvhMYrma7YcIcK5m+EbL8=;
        b=HT5pP9GMNDhhn6oyvBggfa72VRmyYoU1Sh8zhEWwlDN0haTuvBNGDWcnOEa178ANZH
         0aSSNdss8gIS1scw2nx7kb+Rs4CQiroO8uuK2f0wJlqf921wTBSIWQNPdIKRE3GnKFE9
         t9MhUtfebtJChZq1UdsXtjgLZgYHaxEB75Bda3JcrDHu7JDDXRA4nJr3tnpp1ODos/Bi
         MGFUb10LQbBYkF7DfahQIGbL3gI+9pHq2UUPV0QzXiu2nlzNWKWgfUMtSwUkkIZmqf4Q
         NqRWDCOahg8Kd7mFmIO8DRKFqefsGX3pZl9/TkLZ/+t9zsA3YLagK0SyYhtn7/CreHRw
         apzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YItJSibc+CAMFtQEZMwaq2dvhMYrma7YcIcK5m+EbL8=;
        b=DrN51bj7mw4LPUHQyrqUGEq5AFuNIIHxB21qW2G7QJPAHfe8V0R7tNzbjl6vH2Rcvm
         9l10U+mPiX6Gdb2CfIdj20FEdrXoRVWn1/VA8O/GAN+GmvuCep6KN8FHxkkEWlPsgCIX
         K9/UHHjXMw+lrs+1Ds25M5DQpEMXj0W6Dlu1TpQlTmXPQAn8KizfrOZ32mkAI/7c/afr
         NmNfDBKDZF0IS8ZoGRjlCcrghHcxX05VbNcVyXkA8RrdbZlikxdCT524JuiDs6ndK/gX
         uwJuM4eHHn2UK8bcjMBy+xDU9MKx0raZajbI+S5v5YWVfSNLvQkbEPLEE1aDco+thVT0
         sYhw==
X-Gm-Message-State: AOAM5323W7KdQLChXcI0eEAsshkueLgNWG1jpmh/OEmX8HyUl21LtZF4
        HUcDO1G4vVDDr12Gr/tVztIMaQTBOQGDtQrQupw=
X-Google-Smtp-Source: ABdhPJwUJIY6nbNCYrr0RZgIog7RvAFy7ewt+QG1scAo5DpRxx6Ni3SF5nm5xLPhhFE7Ao61jMVmFAQ8d6LabVabOQY=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr14266847pjq.181.1628152216075;
 Thu, 05 Aug 2021 01:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210803194039.35083-1-andriy.shevchenko@linux.intel.com>
 <20210804200025.iqsvknddoxix7yw7@pali> <CAHp75Vc1r+9N6_BiJzO3JYppgaokKiQwk4sLrp72kPEDgYEweg@mail.gmail.com>
 <20210805081153.5exc6iih2yu5a3ph@pali>
In-Reply-To: <20210805081153.5exc6iih2yu5a3ph@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 11:29:36 +0300
Message-ID: <CAHp75VcioyOPfTWV-z-_6EYna5jk7N2zaxuK+nXiUOPV-qnCUQ@mail.gmail.com>
Subject: Re: [RFT, PATCH v1 1/1] platform/x86: dell-smo8800: Convert to be a
 platform driver
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:11 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Thursday 05 August 2021 10:20:40 Andy Shevchenko wrote:
> > On Wednesday, August 4, 2021, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > On Tuesday 03 August 2021 22:40:39 Andy Shevchenko wrote:

...

> > > And in which kernel
> > > version is (or will be) introduced this ACPI infrastructure?
> >
> >
> > I don=E2=80=99t remember, I think it is in v3 era or even v2.6.x.
>
> ... and this answers why.

Since you have asked, it's v3.8-rc1 with the commit
91e568780588 ("ACPI: Add support for platform bus type")

> I will try to find some time to test this change on a real hw.

Thanks in advance!

--=20
With Best Regards,
Andy Shevchenko
