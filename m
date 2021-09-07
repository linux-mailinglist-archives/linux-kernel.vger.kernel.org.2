Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3186403049
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbhIGV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhIGV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:28:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF61BC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:27:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w8so204693pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Chby1I103cCIUjx2Pr1mMoXi27BMhl4OPMXZ/OAAfSc=;
        b=fzUU2Iak7Q9DlSAS9eudlQVvZf5wSAdkok02sTBgnyi5AsjPEQPAsPbuBOdSbOeohL
         rxQHwQ29wlft9KJMqhM6eAjWtqGpVIVRRsPkwhqfEctrPoY+XYTvqsA5Pzqh3MMUtwj/
         GkS33+nT//Wrv3TTzctG4f7t9LccDnmzbeSWbM1icCdXUd0oQaVtooh5aLP1DkrX+To+
         9C+YaHOue5bpbYkEBAE3HvbExxj5ABqo+6fM72ckzsL8rsFmBcwnNRDOxbBUlrM5hcIT
         SPhVP59Kcs8mfQ+IOZCAsy6oCj4mns9ls87pnM4MVdCj4Dw4/eM7I84m6KgGiUr5fhb2
         OCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Chby1I103cCIUjx2Pr1mMoXi27BMhl4OPMXZ/OAAfSc=;
        b=ChZ/g9pLp0wUTQa4DSScIk1YoYYXic0BssyheTCqjFU2QrteX6u56uGak/metP4fy+
         F2DCfItA1CUZ467p9Llud5FrswKVgglaBTw9ycQBNEwUQswjFnPXJUVczdiEPjuCQAxp
         DCx200Ud6UqsXbUgQtsDRowkarFvI2ykskFd2WJvEP3uRNxMWWUF8VIXI/8Gy/V2YXvc
         FmR8ysr50fZbeDkCUvF9A3iu59jFqiizX45Kw4Dfbc4p7ZW6JmV2O6i/xGkzEbU1ph0v
         t75R4uE9Wo8XN19+c2YbgaLdu3aQ+EsVyLb0qvq8Pgwuvu7sExgF9SzE1udssXrMTsJj
         cPhw==
X-Gm-Message-State: AOAM5300p6DRccXQgyvrcPuyAnan6pyDSNCEZmnkQomvSDz/7S76O0HR
        x8NlqDf5kRRRdkpGb7NB7Oo=
X-Google-Smtp-Source: ABdhPJx6UdSG37g20A1AUqvY3OWshOmWPSs9nNP0pgBwa/nzbjhALgQa7Ad+L+fYRUv0bHe1htQpDA==
X-Received: by 2002:a63:da54:: with SMTP id l20mr323092pgj.341.1631050053192;
        Tue, 07 Sep 2021 14:27:33 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:998a:2486:f524:8502])
        by smtp.gmail.com with ESMTPSA id s15sm48978pfu.67.2021.09.07.14.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:27:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 7 Sep 2021 14:27:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [LKP] Re: [mm] 8cc621d2f4: fio.write_iops -21.8% regression
Message-ID: <YTfZQoMhZvQy1H53@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com>
 <YK0oQ76zX0uVZCwQ@google.com>
 <5abc4469d16535119818e8e72173398d@codeaurora.org>
 <034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com>
 <YTeZm71hmcbJp+E2@google.com>
 <d4902ba55d51c5b4a7b9e01414391f0d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4902ba55d51c5b4a7b9e01414391f0d@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Sep 07, 2021 at 11:46:02AM -0700, Chris Goldsworthy wrote:
< snip >

> Hi Minchan,
> 
> I believe that was the first iteration of your patch - there was some
> further feedback, such that this was the last version you submitted:

I totally forgot it. Thanks for the heads up!
I just sent the new version to prevent confusion.
https://lore.kernel.org/lkml/20210907212347.1977686-1-minchan@kernel.org/T/#u

Thanks!
