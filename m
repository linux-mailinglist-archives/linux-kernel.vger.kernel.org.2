Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AC40AD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhINMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhINMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:13:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:12:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t35so11164879qtc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0m8YoXMgG1crnCPt/39VMUSJpuHCvLuD4Bq99ZM/h/o=;
        b=MlX97dF47qqDsV0jqCq7TvgIjZ+fLI3+0xZuolu5IyYJBpxoHlweELTuB/17lHf68J
         +z/Hg8hO+c8ata8UGv78cQMaas2DhemTPZ4PQE9hU6Jc/WfULnyfPjNmZO74k002zRyv
         NbLiWC4NQA+zOdK44lUWmB03tqzDJ8fkzgJma6/QZM2emd6RgengWoop2FM3F1mNkXU/
         lNogzcfwTigwVHKWgRzwZ0ALfRqgE0TS31aoT489CrRVDY7JD4fBI7mf5F1fx6KI1muJ
         ge6O4sI/+OAkSmGteF9Kh7iPIPy6Tfenl10WEVrjkknQNyJstFjoc/K67V6JANjRCJPe
         llKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0m8YoXMgG1crnCPt/39VMUSJpuHCvLuD4Bq99ZM/h/o=;
        b=np9N337V/gtldc7I451OYU2LdeDWTPlM7nvLkndRKc1ZvakdE1f4PF3XJRKOullE/h
         pn83LVIeqNOrloFi+ZPQB1sYCzhIskTULlFFNm49OEPN2w9SYysadO0oOewjgVqZxoJs
         61hkLx8WoCGNOL+R2vPCUNvkC+gfzdJkk8jZwiY9zDis6mKtFTCcigP1GOtqaoHYH4uv
         LX3hYmA4NMRs9WwkZQFA4tta35vCRox5uVx7WjfJ5CnA+cEBnmA/vJeDPnn4OdU09Zok
         +AFY7r9eHdH3c28msq+b2aSQNNbMwRhyzVflVVJhw13EOEpH6ufHWhKixhPJsy3j2ZK+
         pbQA==
X-Gm-Message-State: AOAM532hogStr1oG6IrTGtFUyxyub/Ceo2cV4y+kv7ozXshQD56A2Qn8
        mJ7qWhwZ2qxmaf6syeXUhG3rOqu99wX8GT/wo/Z0Tw==
X-Google-Smtp-Source: ABdhPJyP5AGpXanp5wz7BJlsvOK8phQzjFiPdeW3a3/m1nrZTfsV4oskwTp3PUuoM7ezO8vAfoJN0hq/RRCHPPA2LRI=
X-Received: by 2002:ac8:7482:: with SMTP id v2mr4321263qtq.235.1631621541584;
 Tue, 14 Sep 2021 05:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com> <20210907141307.1437816-2-elver@google.com>
In-Reply-To: <20210907141307.1437816-2-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Sep 2021 14:11:45 +0200
Message-ID: <CAG_fn=WEZ=W0DzLqbpmG3kgL4QjvBr7OfnPKN_peeti2GYB5Pg@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib/stackdepot: include gfp.h
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:14 PM Marco Elver <elver@google.com> wrote:
>
> <linux/stackdepot.h> refers to gfp_t, but doesn't include gfp.h.
>
> Fix it by including <linux/gfp.h>.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/stackdepot.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 6bb4bc1a5f54..97b36dc53301 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -11,6 +11,8 @@
>  #ifndef _LINUX_STACKDEPOT_H
>  #define _LINUX_STACKDEPOT_H
>
> +#include <linux/gfp.h>
> +
>  typedef u32 depot_stack_handle_t;
>
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
> --
> 2.33.0.153.gba50c8fa24-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
