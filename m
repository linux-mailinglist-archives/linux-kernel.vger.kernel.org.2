Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8A415514
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhIWBTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbhIWBTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:19:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C58C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:18:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t1so4688150pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ZZhCH2Vnd9Kt434pHuZ5hWp8c4ouJ+mtsF91bOXzZg=;
        b=Iql8bew1lM69HWtyICV0+BCANpENNBcAFp4oOs9104KnsgYi0k0UcUi+Gp6+XFvM3I
         aRP8DBJXqm3/3B08rDJmVk5cSF08y8n98N5OtbpT2T+hotbc5KYM+4rKGAKABv0X7R4C
         OIC04MvKfjAvy/aO8RTAvT5pO6CGayq24kgDH34Ln+4GLrCLaAp7TdpKYNBaKKeIJ5gl
         nEDospbtY0QdtdW+KEC3CVnA8WmbyQvgo0WYEvEDaVp8TLzZPwBNput7GiASnUVr0VAm
         L6GCSKBIzqEbVL5JoCxs2ufosiUNAGa0FOw+lJQ7jNBbfEfyh25avvsIbCClEFKI3HdE
         az8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZZhCH2Vnd9Kt434pHuZ5hWp8c4ouJ+mtsF91bOXzZg=;
        b=6i3OX6/Jn3oO5uOHR5vDkWZtfKgYswPt3YK5updn3MsxR+jibvw65rMuFZ1Pxy0EVj
         cfsSy8oomb4gLSAQd/cjCYjg2JLAaxFkU8D1UukaNxrdTWUMKG7KGaDwbYYxIuVAI0fV
         /5wPpvB/9rQ6q0AYUYDpefLR8KjZwSFVu8opge5HoQQfJ0umu6wQgcHmzaG7OiEdbMPE
         QIcOMUxGskfWBrnLQ8d7CaV/Be9wxDYLLFEQugagOkJDER0eFUmkKm19WyPYkAMe3ss8
         26rmpC0c//x46Cfkkk0aq2+6PRtl548dMlIMfgvON3CYcEHU3Wg4dLDygedLgnDsJp+s
         NIKg==
X-Gm-Message-State: AOAM531/VRnVXtn2FibFz03s9y69EWtM8SQ3i2QV3IwqW0pEsYfBefGB
        d4YOL4gcUiuWJnQ+c2tU2RvZ0A==
X-Google-Smtp-Source: ABdhPJzG22UYMspocoNbhZgvqYlLmmWhc1d+fiZjdH0gH0SD98L4AoLfnuLiXlXYO7zJlcYUbBab6Q==
X-Received: by 2002:a62:5216:0:b0:445:49d9:7b09 with SMTP id g22-20020a625216000000b0044549d97b09mr1998650pfb.60.1632359892387;
        Wed, 22 Sep 2021 18:18:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id mv6sm3386091pjb.16.2021.09.22.18.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:18:11 -0700 (PDT)
Date:   Thu, 23 Sep 2021 09:18:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf tests: Improve temp file cleanup in
 test_arm_coresight.sh
Message-ID: <20210923011807.GC400258@leoy-ThinkPad-X240s>
References: <20210921131009.390810-1-james.clark@arm.com>
 <20210921131009.390810-3-james.clark@arm.com>
 <20210922110012.GA400258@leoy-ThinkPad-X240s>
 <5a1c5eab-d9b7-5623-2d7d-c6b1921b3628@arm.com>
 <20210922140832.GB400258@leoy-ThinkPad-X240s>
 <85c593b5-5348-8e9a-b9e4-bc4d31ffc785@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c593b5-5348-8e9a-b9e4-bc4d31ffc785@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:49:55PM +0100, James Clark wrote:

[...]

> > So below change should be sufficient?
> > 
> > cleanup_files()
> > {
> > 	rm -f ${perfdata}
> > 	rm -f ${file}
> > +       rm -f "${perfdata}.old"
> > +       exit $glb_err
> > }
> > 
> > Sorry if I miss anything at here and cause noise.
> 
> The problem with not re-sending the sigint is that if you want to run the
> script in a bash while loop like:
> 
>   while ! tests/shell/test_arm_coresight.sh; do echo loop; done
> 
> Then it's impossible to exit with Ctrl-C and delete the temp files at the
> same time. It exits if we don't trap sigint like it is at the moment, but
> then it leaves the temporary files. This change is so we can have both
> behaviours of Ctrl-C in a loop and keep the cleanup working.

Okay, I cannot think out better idea to handle this test case;
so current patch is fine for me.  Thanks for explanation.

Thanks,
Leo
