Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167D74011C7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhIEVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhIEVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA19C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3400982wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4YpvGUOv+fAgJ5K+5ei4WUi6BOg1OIJGekXtN39xjs=;
        b=dXVMRi3zMhjmJvVW0ztKYFLIH9hwW71q3rSoiBhuX2JAew7WG/mNKSlPSH44skCBxp
         vBjN0SR0fACkQVr2RnkwK3jnJw+sHwzaPJt5brAEpo1EUz0q8j2fv3x7QXq+GJ1wGZbJ
         I+fqR0tk/CWzgIdAzTi0fnfenkSlFORyRAxecmJnCp0Qu3ICJvCYQm/nxBDtXa+Tmo/+
         qIw0dYcsow9BgDsFoqWEcsErz9rCYXoHIslSrBgiM7OJg1RWHq4nw90H9fCVBd9EX11X
         zm2RwN4olK5YUFB+zEmUczZsdNp9l8ced7oQ5MheNOfCViey1uOJZUi0vSPIJERMZh75
         7JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4YpvGUOv+fAgJ5K+5ei4WUi6BOg1OIJGekXtN39xjs=;
        b=NNJZsM4S6ttHjVUkZmwbP6ZyBIdE4eQaXOjdwpLmYLdEoFJIIvN8BQx1Pnm9QrnMx8
         mxbTeU1C5+V0MTHB9RAmOWPwjMnsAXjrSjIKj3TNaQC0HggyPbulxiytjiPZ6mrqKiY6
         Uk+iS4bU7y6M7Q2WxznII9VPvEnLLekZvLl6NEiSLDxL05q7Kp50hjxq+njDFYkqv3Nz
         wp77gDdHk0EdKmyDkp5P+mjxFH8YaGfwcmg9QrVNIpkAYRHVk0AH0PC0Va6RLjOBx5hn
         sRzR4bD7VLdKeBRnQ0JjFbcET7yFwf/I36zR0ozhIR9m56e10U8TIHNRNAhed/8rfQjr
         o65A==
X-Gm-Message-State: AOAM533SPAyUd0iAqsg+eBypPB7t/Q1H1/M12lCZudlo0IXBcbFXJJuW
        Q6w7mltcjEyodf3wtD9Y0SXmybWOPguHyss+eDAavA==
X-Google-Smtp-Source: ABdhPJxQpNtJ2bb0D/m2IMW40sK7zBgzK/0MOUJ/OwkKrz2JETDgarpa+KQ2ucuqANQYhBp2nt4/XW3KC3r6Ivzr1Jc=
X-Received: by 2002:a1c:1bc7:: with SMTP id b190mr8648358wmb.57.1630877083849;
 Sun, 05 Sep 2021 14:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-6-james.clark@arm.com>
 <5679e1e1-b5c4-b763-2fe7-7dd8b7ef1a9d@arm.com>
In-Reply-To: <5679e1e1-b5c4-b763-2fe7-7dd8b7ef1a9d@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:33 +0100
Message-ID: <CAJ9a7ViotCWg4r+XgTtpmEpUJ2Gq4y7wpL7HCvcFWnToj=h8Cw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] perf cs-etm: Fix typo
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


On Fri, 3 Sept 2021 at 10:09, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/08/2021 14:41, James Clark wrote:
> > TRCIRD2 should be TRCIDR2
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
