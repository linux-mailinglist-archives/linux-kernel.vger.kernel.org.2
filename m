Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF14011C5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhIEVZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhIEVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24FC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3407512wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHMMjMhivqxPIC3BtkbJ81QY4VqIQKA1P04hghydQHE=;
        b=blzt7fZtvB6K4OGSadqhLwBVNex1NyJ8EpCK6MYDlLhG7ABNf22VxXThAJSLenmGB2
         HDlwrnAgLuunPi2Yavpb4X7ac0ESpxiLtJCxRzS0KI/vOkSG+l1bf17zk4lFq0pjurHU
         9THFIiJSjBYKKXTaFmuR/3US+nX0kT+2lzGjki/2AtxOqvQdwxGWREmhkh08D8Dv7yi3
         ptMvOuJcOy2Io9OHBnP2X1k6uYRTS+EsX7Ep3ZmyIlVzB0umMTR+srV4pSfiFeisYdvO
         lOzbuVEDxwgIYrwwonjf3jgsqe87xMb4VQIBIZ6r13NDUJU3QH20Gusf3Ackqd3mDSOe
         m4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHMMjMhivqxPIC3BtkbJ81QY4VqIQKA1P04hghydQHE=;
        b=M/cnGXULWkqbSVIDS42c2HLEy2g+PAWD87o94jJj7Expc78F08uaXw0MKlrEcbcmtG
         QEd1bt9m6ghD+c1J/c7dnQ9QEMBqjwlPByjpFkpOzbRhQv49OOsUezK7LOf1ER9UyUYc
         lcmmypiC72OpCieqq/43fYGCTw3nC+ky4KbOf03zQQmE3BBCh5zbRYV6jgclKcMibKy4
         P7uIxAaxooOXdU1X7Oe/EIsjNudMHBNM2tDzH5+mMfa1xUiewBAaak6nGxX7ImIrNL4x
         /IjSLMMiQDLN9tuwDZ98LiyjeRZJXvWKeSShh3mEhEsn/8T1mbp9lQbHjZAb3s373nxh
         puGA==
X-Gm-Message-State: AOAM531MwemDFfEGolBwF/T4cG7WNIlLoObF1Jv0PxkaZyoOusvBbnR4
        G/MkyEhLBKNAAoHFvc3WOdyivNB7HcyeKEOJWCCTjA==
X-Google-Smtp-Source: ABdhPJwCr66YTIe29GSyel5c8aNkiSz88bTezmxuBX+hr0RdF99snnNSHEBKn/tKUxxYLOBikYsO/dQMOnYirgwBwsI=
X-Received: by 2002:a05:600c:5123:: with SMTP id o35mr8587349wms.153.1630877077157;
 Sun, 05 Sep 2021 14:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-4-james.clark@arm.com>
 <b0e6b1d8-f9a7-676f-c739-314b91388565@arm.com>
In-Reply-To: <b0e6b1d8-f9a7-676f-c739-314b91388565@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:26 +0100
Message-ID: <CAJ9a7VhQKvgzwkdUNTApYvD4jPGP+ULQ4MnAjbqOwve1L=9d5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] perf cs-etm: Refactor out ETMv4 header saving
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 09:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/08/2021 14:41, James Clark wrote:
> > Extract a function for saving the ETMv4 header because this will be used
> > for ETE in a later commit.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
