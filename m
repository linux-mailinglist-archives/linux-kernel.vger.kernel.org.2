Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7471366F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhDUPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbhDUPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:44:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E13C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:43:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 31so14731552pgn.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQIKSdyMaAFNIb31h2iG6av9jYGz8haKT7A+NY7sOoA=;
        b=wNPYHWJ9Gt8wZJZRfASgFYcicBDENSG6TL1s3WITr1yRpM/iWEdwMT6DXlqBh8KqZd
         RoLnsPS2nlFXVfAmzH2cgiCPY6e9v2Haq1FnxMHmrBthNoOvYYqUJ211sIvzHwdSVeiy
         AP4JDCJMWiL5GSUWCFfNw8JZQPree1io9VSadqztBAUKR9vPC8Hb8nu7OEbQXHBOZl2+
         bhpARQglccI3Nvi/m+QPPLPNZ/mhEn9noCXKEH/2HbLloh65VZ4RrOX4F2Fol82g35Mu
         vaOymDgzBgjuAkbfFAgP8DGDcW802jB4rLDbGXsEKfws3xPrwmFOi/WiIeGjLxNFGJlq
         gOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQIKSdyMaAFNIb31h2iG6av9jYGz8haKT7A+NY7sOoA=;
        b=kglEVMHqMXPdqvcbBN1A2D33Xxs7puf9JzPecibvJVoTgIkMF/AYenomNAwUTOnHSH
         mQfLlcfl1tXA0AJQ5YCewRMfooQSfiiYvxjJ/rfWHFOrn4+VVJDkHq8IxRa9LgDd1xIA
         tbEht/ZVy0I8gz2UcPNjwI2hwokrJMIpfruOZsiBjUwSgcAdOEgfoT2suNeeJjxoFF9c
         0bc9T2qx4gOttqKiahZ39dsFfVEW+BByVPLwXremJM2xCXgNRPAl3ryOBRfeJJ2U77ZO
         T7rByvwFhEZBWGY77bDSOC16VhOaqaSvmPhU+zSHwxzl/5xPJMOA/XZwrM6RM853fBnz
         Csuw==
X-Gm-Message-State: AOAM532EOqoK4e5csDEnmKyIqDG/g9xCiEWT34dPUQkjuWd61Jw1WHSQ
        MY12MHiCAG8woDPrgAwbs3Bxl3TICE5RhZiyKpHxZWRzcIQ=
X-Google-Smtp-Source: ABdhPJx5FPfNRwjUi4d2wREsH5ZgUNA0KzwB6DPKVwaF6TgA3M30qZs4jPElcuj1QgoU4k9k8MGlzkd+2L+pKA5NTFA=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr12108571pjh.19.1619019835981;
 Wed, 21 Apr 2021 08:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-11-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-11-gregkh@linuxfoundation.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 21 Apr 2021 17:43:45 +0200
Message-ID: <CAG3jFytfaOoJihOyxjMjzRqUOCR+fKhO_nPxVnO62Up0gvoGWg@mail.gmail.com>
Subject: Re: [PATCH 010/190] Revert "media: camss: Fix a reference count leak."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for taking for preventing this type of abuse.

On Wed, 21 Apr 2021 at 15:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit d0675b67b42eb4f1a840d1513b5b00f78312f833.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

I think this patch is good, NAK.


Rob.
