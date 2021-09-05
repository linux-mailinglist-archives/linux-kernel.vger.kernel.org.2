Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECD4011C2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhIEVZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhIEVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE970C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d6so6163310wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIHzJG4x/c4ord8UABpO4rbP8CYuI6K54GyJYQGHzAI=;
        b=agFpB5V2LHqzN/WezZ45hmFy4eBJHgY3DPmoBc44zGmhj33+AZZCgnrpKbPmJz4e11
         NBHmwMKDeExPU7oEMWbaVuy1aCHK9lhgc8gu+UYy9mjhSkO10zItI7ROzm5hkmbO642Z
         0efQFFVJ5Oj6zxG/lI2hWyi2EegTlN0Ot6uAmswavxPOMFRpL179Gxf2IxRsPqUV8A0P
         XF3cUKBUiOoFjn6e7r+oJ1NCG6Xyk/E7exg+mQN86kN6HHyhYHiiT7M5++SM5Ozr3cfM
         XnPvGrUtkEL9DI9Iqc5uCjhwTeS5YueFH8pnSNetCc8rvZW95MvLaY4N9QhxqdeQbIHm
         PwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIHzJG4x/c4ord8UABpO4rbP8CYuI6K54GyJYQGHzAI=;
        b=GlnKKuZba44v34Z008WIWKGS++Eji+58T3rN9ePWqrRNt7mPcTz2rvl1IW2JekFJy9
         HHZBB4MYJJFD73M9d4g6A/3/Zit1GkDOrmh/buiUekWqZgGO5H9qL0lAlz3fba8eti58
         14xDyyJDtO/Vwui5EOSnOQ75PL7TJs3uyplNqPDU7FcMJgIYAq/IsfwmpwZh9qoWgGja
         ue4byZTnW6CjZGlx1YLgIdT+MxqTPvCYOvONbUGdEyy3Sl3Z/dGVNJYKCRsi2I44VJZu
         6ANa4QQE99ukWlov7VD/cRqgejLveDq3FLro6s4IwQQu7ATVK9aAlJepeYeXfc4ol1w/
         CHdQ==
X-Gm-Message-State: AOAM532a2aT1FPOvJKyFKYUfJaHhd+Cl3go5YEEQQAHQ7YDfJbMnOVt7
        bxN1GJ9IM3k+Nac6s+/LbKrsoC5S5wsVitAbfqM19g==
X-Google-Smtp-Source: ABdhPJy3s/jbX+WLj0q9CVzf3rldsR+LVYL/ZwbCD1eARpWjluKyEpxWEa8hk9QBc1/qGZ/UDenX0U9L8fdkQV0rreE=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr9838565wrw.134.1630877069272;
 Sun, 05 Sep 2021 14:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-2-james.clark@arm.com>
 <ca0f3d7c-2420-fcab-0c48-57225ed15b00@arm.com> <YTIBYkU281/di+vD@kernel.org>
In-Reply-To: <YTIBYkU281/di+vD@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:18 +0100
Message-ID: <CAJ9a7Vix0zO_AG=zq5iqx+FaG_ZDaj_wZ6ZQ+==tYSXneO4_cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] perf cs-etm: Refactor initialisation of decoder params.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
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


On Fri, 3 Sept 2021 at 12:05, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 09:52:14AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > The initialisation of the decoder params is duplicated between
> > > creation of the packet printer and packet decoder. Put them both
> > > into one function so that future changes only need to be made in one
> > > place.
> > >
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: James Clark <james.clark@arm.com>
> >
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Thanks, collected the Acked-by.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
