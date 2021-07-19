Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2A3CED6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384504AbhGSSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383700AbhGSSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:09:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A6C0613A6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:35:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bm6so4905427qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8VAc3DE00jU/y6BHOt7Dq8IZFxqIDCeAd2CU/bSAzlU=;
        b=tBgEoVYVw7XrKsAR/IUWn/GrGTdwpVKlJ00gccf4xz0UUaPBNQ9b3+nFJ6Spqbo9Oq
         F8NDCyivPbeAu++4sdIgxo1f+cX16wDSdH7VHJgbxWTCuI34NxZz1A5w2E3+qZ7sEnuw
         gergcJeCq1BsZgs9hUw+wzl2SZ0+UnEEjBg620WEoP8XYlHqOsXyhONWJMgUlaB/29eH
         tAKdIWHGUBCqN9HJ2lThRupJpQ9qNinVcKVSOuogsExI8/0/Wd3nUgU5BXYeXxmMyVye
         gd2gu8TZaTdLMyZc6sPu1DelrbKiBBD4u3e52qZGfChBnx/G5yBhYPczqeQhzb6As1NB
         VNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8VAc3DE00jU/y6BHOt7Dq8IZFxqIDCeAd2CU/bSAzlU=;
        b=DBV6SiZGGlXvxH/t4DIv2IrpD83HqGmEdobkESmG8QrkgtD+NmZHgoXgFi4HsxHKKd
         DU9jESAIIUs99QvmzVh951RIMBiDhHx0e2ZxW5hVRWBIS770lka0QxUR3yr9i4WByzMA
         SpoJGYubsQ6nVi9jLHIyxroX7i5B1ZY6sOPKmjCxbYo1z2cSQ1S2iblFma9vYzYQLr2j
         tblwfZ4//W6Sn3HHrujDMwyml8AcI5FNLtDdOzh1B+b3FbBEjFAgHFIiA/lM2jY8QpvX
         3ZMQCsw/oer4N6a3cwl1VLVMYLaJVtnX85x5d8BdSs/W68CUirBNEd1uCyYzbIF2uZw8
         fjVg==
X-Gm-Message-State: AOAM530GqK8rO8r9Y86Qlzkvzl3hgVgt3UFoa0qCZ71fDUi7D7i3hEvH
        dU+7m+Tev6xCf8sfkHVPBh8=
X-Google-Smtp-Source: ABdhPJyB60Nv+E0Ucay9mft9FFOPc8+Q/Y9sO9olPyWkMSguwt2ucVKiKYuAjEd5rWVYll8/IvlRMA==
X-Received: by 2002:a37:5d2:: with SMTP id 201mr25530403qkf.489.1626720428136;
        Mon, 19 Jul 2021 11:47:08 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id j7sm8539522qkd.21.2021.07.19.11.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:47:07 -0700 (PDT)
Message-ID: <9bad590314e0d2b1f0359ec1610dcfb32a79d524.camel@gmail.com>
Subject: Re: [PATCH v5 03/11] powerpc/pseries/iommu: Add
 iommu_pseries_alloc_table() helper
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Jul 2021 15:47:27 -0300
In-Reply-To: <8110756f-a41f-3ba1-d7bc-af15630c4fbc@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-4-leobras.c@gmail.com>
         <8110756f-a41f-3ba1-d7bc-af15630c4fbc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 16:04 +0200, Frederic Barrat wrote:
> 
> 
> On 16/07/2021 10:27, Leonardo Bras wrote:
> > Creates a helper to allow allocating a new iommu_table without the
> > need
> > to reallocate the iommu_group.
> > 
> > This will be helpful for replacing the iommu_table for the new DMA
> > window,
> > after we remove the old one with iommu_tce_table_put().
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >   arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-------
> > ----
> >   1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c
> > b/arch/powerpc/platforms/pseries/iommu.c
> > index b1b8d12bab39..33d82865d6e6 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -53,28 +53,31 @@ enum {
> >         DDW_EXT_QUERY_OUT_SIZE = 2
> >   };
> >   
> > -static struct iommu_table_group *iommu_pseries_alloc_group(int
> > node)
> > +static struct iommu_table *iommu_pseries_alloc_table(int node)
> >   {
> > -       struct iommu_table_group *table_group;
> >         struct iommu_table *tbl;
> >   
> > -       table_group = kzalloc_node(sizeof(struct
> > iommu_table_group), GFP_KERNEL,
> > -                          node);
> > -       if (!table_group)
> > -               return NULL;
> > -
> >         tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> > node);
> >         if (!tbl)
> > -               goto free_group;
> > +               return NULL;
> >   
> >         INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> >         kref_init(&tbl->it_kref);
> > +       return tbl;
> > +}
> >   
> > -       table_group->tables[0] = tbl;
> > +static struct iommu_table_group *iommu_pseries_alloc_group(int
> > node)
> > +{
> > +       struct iommu_table_group *table_group;
> > +
> > +       table_group = kzalloc_node(sizeof(*table_group),
> > GFP_KERNEL, node);
> > +       if (!table_group)
> > +               return NULL;
> >   
> > -       return table_group;
> > +       table_group->tables[0] = iommu_pseries_alloc_table(node);
> > +       if (table_group->tables[0])
> > +               return table_group;
> 
> 
> Nitpick: for readability, we'd usually expect the error path to be 
> detected with the if statement and keep going on the good path, and
> here 
> the code does the opposite. No big deal though, so
> 
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> 

Thanks for the tip and review!

Best regards,
Leonardo Bras


> >   
> > -free_group:
> >         kfree(table_group);
> >         return NULL;
> >   }
> > 


