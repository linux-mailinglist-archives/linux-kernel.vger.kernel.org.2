Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAE3FCC03
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhHaREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbhHaREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:04:02 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF20FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so5876572ood.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aquqJwbc9m/hIVCd01TlOuCXbAUHlFJOz/03vmUb8IM=;
        b=q5jjzmupuZysdq6pWM6sahYpgGRYgqndWyW/wAc+WhHHcvPtSPx1jDAU0woWnKbRbo
         tn/icMFl7O5TPVcbFWiyHWfHBfvH5q4M81Eye4+TLIsH/xh7sS1GZCXpszVjli5RBp7t
         qmxrNg7JaX8/jUCQ5qmckF4xKx4F33oh3CEKEfs8y9TcaZBc93oUfwmnVbwoNriqOyBO
         R9cYqvxZZbqb45UeyIa/tIfRHVBkkfpDqNdXKGaCkcrWV4ntPwL+rWnRq9jw/awNpe5d
         Kr7ft9qBkhKzqN+TUudBVrTf8xbZcd/tYx7zs2WSramLm+f3npGOdIeZzeF7mA5ujJjR
         s8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aquqJwbc9m/hIVCd01TlOuCXbAUHlFJOz/03vmUb8IM=;
        b=lYrPiMjuCt6/7bN0qahLpq3wAaPhWntAkleo+xxLVopaNOy54ghcEeupLdrjHhJwzQ
         on7VLe/nI5WIfhMRE0VCQSSYD9Rkqwwk7MmCpfcPAZ0zUMVR+OlYRWmEcT238ncdh8fN
         q5S8/fufAQ8rbilCaGF5S29f4b9wxW1LBHgfdQuB7B6bZQ+VngfYbLSrYypr4yY33ue0
         7lmRvaney0l/UG1vh2B/7RjS/AfX2AIzOttZJt44W2ADo9e/SbaKci9jnKJbIPq4jpPO
         71VmzZ3AyJegazvaf2ZnfT8Do4TzHeWfnCF0ajKoshucZnusAKaaPuu0wz7g+6+82jRR
         z+Ow==
X-Gm-Message-State: AOAM530AX02bQCf6VaTsqmAhbROaKc2DsPNdTQE/ssamT618B/WEjEkw
        osV6sMrS94Tc1ddXq4FK5UDVTw==
X-Google-Smtp-Source: ABdhPJxKKFdY8MvkADZc3EpXGvVWUIRpCwdjGVe7w41nCD/MZyO774PBzlWQ8ANv/3d0FU5rFERitw==
X-Received: by 2002:a4a:df43:: with SMTP id j3mr15210793oou.37.1630429386025;
        Tue, 31 Aug 2021 10:03:06 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y138sm3647410oie.22.2021.08.31.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:03:05 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:04:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
Message-ID: <YS5hDq+xblntYbh0@ripper>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
 <YS5LDb4KDFx/dRnM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5LDb4KDFx/dRnM@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Aug 08:30 PDT 2021, Matthias Kaehlcke wrote:

> On Thu, Jul 29, 2021 at 11:34:44PM +0530, Sibi Sankar wrote:
> > Fixup the register regions used by the cpufreq node on SC7280 SoC to
> > support per core L3 DCVS.
> > 
> > Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> This patch landed in the Bjorn's tree, however the corresponding driver
> change ("cpufreq: qcom: Re-arrange register offsets to support per core
> L3 DCVS" / https://patchwork.kernel.org/project/linux-arm-msm/patch/1627581885-32165-3-git-send-email-sibis@codeaurora.org/)
> did not land in any maintainer tree yet AFAIK. IIUC the DT change alone
> breaks cpufreq since the changed register regions require the changed
> offset in the cpufreq driver.
> 

Thanks for the note Matthias, it must have slipped by as I scraped the
inbox for things that looked ready.

I'm actually not in favor of splitting these memory blocks in DT to
facilitate the Linux implementation of splitting that in multiple
drivers...

But I've not been following up on that discussion.

Regards,
Bjorn

> Sibi, please confirm or clarify that my concern is unwarranted.
