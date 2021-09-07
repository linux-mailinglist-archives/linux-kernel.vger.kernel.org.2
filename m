Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F94025FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhIGJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbhIGJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:11:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17827C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 02:10:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a25so18340771ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n5+hR87J9jGsWkS18UhQx1xHYTAbX3jyL7zc+byYnoE=;
        b=J6WXwrXM6MdanWnIZTBBErxz8LsqiBupx2Hk+Qs04dCov+47QRyfhsn0Whb+ii1Ir7
         CZinwkkKrXjXlx1t7HWzAg74O1S0dghPmdZy9FQY9atom9A6shfizVVmq2oy/iiXN9Gw
         6HyJAAWLK96z6VzsWqPWuJj/Bg4F/2MHmHSAhIvdnz8AM1QIJgqYh+LfQJx4ZjfgWPK7
         3czXE3s/2HG+EU+KsT0Xe9L/PRrAqYDD2vUmMMDbYmeOK/jIrnHPWw5WGMqTClwMSkYH
         tKhFW+zIycZxNlyacYrdDxXy+f3SYv7DEGG1W+214oadaY13qnBnyZzLuEGSi1kEfHA9
         70Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n5+hR87J9jGsWkS18UhQx1xHYTAbX3jyL7zc+byYnoE=;
        b=i3CpOE3+YlXfZ5uVMbM9pYyxYSCilK3BGU8iVwHSsg+KuAMoixw4Tz/QTBuu89QXHC
         V0T+MVLn72fYvM0NZHsK33zmpSsar2927rTjmRb+PA4drhu5Yu9LPKY+Z7Sk6ozZ+6Lp
         9Y4AJG1f6xTypmeHSv1vNwa7Zrwk3KQAT5JRlzz5UGnH/tMzNTgZdne0XY7dcA50AtH2
         86PgD7nwzXTPkNWl2jFz3gKTb2JN2RkcPTq6gY+VPpY2FZEJKA04tjjL9KEGMKQrWKr3
         ybvTiWt9+UVSM2B5jOiurtFrkgBGb7+whovPw5qLqU6cahBKpBrqTVOn4+qKE9qeUa29
         tTbw==
X-Gm-Message-State: AOAM530uS5ZmZoTcxtxBdZMm6/4jb2XavK7g9C7Vl77PB0bsBZZCP9N/
        jILqSVtwXR9qoleq8ZVb2ndXsg==
X-Google-Smtp-Source: ABdhPJy/YBmN91bP9G+ttPy7MX183v9h/jDq0tqOedtJk2zJwFGmDKT/uiQ89oLmV+arDTeAnMIjEw==
X-Received: by 2002:a17:906:681:: with SMTP id u1mr17366604ejb.499.1631005808680;
        Tue, 07 Sep 2021 02:10:08 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w13sm6525460ede.24.2021.09.07.02.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:10:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/4] block, bfq: do not idle if only one cgroup is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <da0e53b4-e947-9c91-832e-36da67037f0f@huawei.com>
Date:   Tue, 7 Sep 2021 11:10:02 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1ADC992-11AE-4511-9033-D233CBCA6F26@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-3-yukuai3@huawei.com>
 <21FA636D-2C21-4ACD-B7DE-180ABB1F3562@linaro.org>
 <da0e53b4-e947-9c91-832e-36da67037f0f@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 2 set 2021, alle ore 15:31, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/08/27 1:00, Paolo Valente wrote:
>> Why do you make these extensive changes, while you can leave all the
>> function unchanged and just modify the above condition to something
>> like
>> || bfqd->num_groups_with_pending_reqs > 1
>> || (bfqd->num_groups_with_pending_reqs && =
bfqd->num_queues_with_pending_reqs_in_root)
>=20
> Hi, Paolo
>=20
> I was thinking that if CONFIG_BFQ_GROUP_IOSCHED is enabled, there is =
no
> need to caculate smallest_weight, varied_queue_weights, and
> multiple_classes_busy:
>=20
> If we count root group into num_groups_with_pending_reqs
> - If num_groups_with_pending_reqs <=3D 1, idle is not needed

Unfortunately, if active queues have different weights or belong to
different classes, then idling is needed to preserve per-queue
bandwidths.

Thanks,
Paolo

> - If num_groups_with_pending_reqs  > 1, idle is needed
>=20
> Thus such changes can save some additional overhead.
>=20
> Thanks
> Yu Kuai
>=20
>> In addition, I still wonder whether you can simply add also the root
>> group to bfqd->num_groups_with_pending_reqs (when the root group is
>> active).  This would make the design much cleaner.
>> Thanks,
>> Paolo
>>> -#endif
>>> -		;
>>> +	return varied_queue_weights || multiple_classes_busy;
>>> }
>>>=20
>>> /*
>>> --=20
>>> 2.31.1
>>>=20
>> .

