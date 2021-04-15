Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C042F360F34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhDOPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:43:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:43:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s7so23657879wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNkMGzubXRxw57h3TICWZ9B02X30bGEcbInmKNYGThM=;
        b=udNICUrhXQth0zC5lC/KWtYgmfoTrW0teUsWz47d1euhA51lzYNCbh/ukJMs5ZWER+
         ixOQC8S0ydmBygkgeNksKe5AjD6izMLOH5HgybaG3KFGJVKZa9B9k6ko+e/cMfyQ1uZM
         vCprxBDtOn+1iw6MhKpGSaJyQyxdMAvM7BskbIQKLE4dVeJS8RQTzui9xdAUGtoC7LYi
         IyuHGu1Nv45w+xHOdDEnAnm5Jcb1w4j/51oHX/hEGsuPbYkQNZeVZhmDyNqNya3aT0eZ
         cOUFagJNavjoIIF4Jhtk36SMEo73ujx8nSYYZtJU/HHchVM3Oeo3vnfVRD81KH3fsxWc
         B5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNkMGzubXRxw57h3TICWZ9B02X30bGEcbInmKNYGThM=;
        b=mxs7aKPdftAanY8nvuU5h/n0e9nkpQs/wy7xsdxHAgAAcNRM/1w9d7SaUFeOt/jOBy
         nXaguXE5UGFLqIx+o7B90rnuZF3Luljpl4NZKW7vQdRn2Kfg8WSQou8EFeRNbxGkqSaF
         tkI8ksJoTjErSmotvSj/FsOYQ85RgtzBoAcQe3LorQmy9t9Pa5BfwZ2UUfABeLnyvsVE
         q/tyetKnO+Sds465vtcSTnvEkOrvFkCL5wwiO/pvTuetp9V1cNu1Vf45Yo4Wu7oKeB45
         h099TqSi7fMBn3FrmYkCvYT4dz5QlLuWFeVlRMtKENj9BGJ+fHauF/d5ZWLyHgl91v6o
         wWIg==
X-Gm-Message-State: AOAM532JaRF3OFc1bRSyM7pYth3ZaRYS4oNHG+iOkqF+r3oCnPCVk+Zj
        WvLs2/XYk9h7VrgrBBlYoDnjCQ==
X-Google-Smtp-Source: ABdhPJzPoVA0W934lS29ibclMrJptcQX/oaE0xjn8AVXj8t/bG4V74/s3PpeqdBqA1otJe3B7qo2yQ==
X-Received: by 2002:a05:6000:186d:: with SMTP id d13mr4244100wri.199.1618501389832;
        Thu, 15 Apr 2021 08:43:09 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id c1sm3961297wrx.89.2021.04.15.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:43:09 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:43:06 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHhfCr+7KztYpIkD@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
 <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
 <YHhZrbLcUD6I83m1@google.com>
 <cc9d7743-7795-a9c9-c1fb-4162cb02bfe2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9d7743-7795-a9c9-c1fb-4162cb02bfe2@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Apr 2021 at 16:32:31 (+0100), Lukasz Luba wrote:
> Are you sure that the 'policy' can be accessed from compute_energy()?
> It can be from schedutil freq switch path, but I'm not use about our
> feec()..

Right, I was just looking at cpufreq_cpu_get() and we'll have locking
issue in the wake-up path :/ So maybe making feec() aware of policy caps
is for later ...

> For me this cpufreq_driver_resolve_freq sounds a bit out of this patch
> subject.

Not sure I agree -- if we're going to index the EM table from schedutil
it should be integrated nicely if possible.

Thanks
