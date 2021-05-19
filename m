Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2902389519
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhESSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhESSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:13:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D32C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:11:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c20so13658358qkm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=or1ZgkIQlqYFYsbWx3HhSVHrt7I2XsoIRsMCoyF7atA=;
        b=I/E/dqxF8ccpwh/ck606guAAMWoUat0ewjyFBZ9qGkhCu+vdKW45Md3waidHfBOcnl
         Eqf1Yqt6PeBfuumUioxkOduMozTmgdMFtcGyfioxsOPJPRJNLQ4jnjVT2qXlY+aMTE6E
         n7D/gwnI3FA/CndzpSeeQcEVAbeVLZcdSje0mF9X8XYry5kvfJA08rwWvgD4wPSJXSxT
         OsS/Aayfy63b6fpecJGRSsY77jP3vVkN8R6CGJWR1dZB/hRSXxQjJgultC8aiJBdp/z3
         sgzp5mgSXuEbYvHkj9t8yxM9KWR7IESTnh3nA7XZ90l/rulprpDCqqE41qNPvP+D22Cv
         UXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=or1ZgkIQlqYFYsbWx3HhSVHrt7I2XsoIRsMCoyF7atA=;
        b=KMsIfJcM78Y1NH8L1LolQ4H5DbtQYIrCHN/vuq6d/YkBRWNQyCSTUG6m2Vo0tXzbI9
         nEteUO1h9e99PWY8qj5HyrWv/lnW5wF74yB0dCeNyQ7tJnyPD/dff+1E6W/NJjvIw+d+
         ElfW5ZNBrKtGGwVnK6Zev/VsfmYSdfDFpUnd9tToLQhTY5qB+WALfi+jtv3e8k4rS4n2
         PLbmZgPPkrNPQVglNR/YtcVHZU6Scg2bHK2a1/oA+bONg5s0ECh6tAD7jekTA27R8E77
         UPmkqpoUuWd9RK3dconEFgpsfNVHJMAi75ss+TeQuBL5U7/Fv3k0RL2FeJtyeRqb4hpb
         DFNw==
X-Gm-Message-State: AOAM533ux3Rtg1z5QSKendG1lpGhk6On6QJQsN42ze0BwKQb7j60BkpJ
        WPqpnXyXzEEzvV2xCeGyNc2IcA==
X-Google-Smtp-Source: ABdhPJx6qAlzcCgcAFZQhi8apeXZnalyGtzPK6kX7YL/irC69Yj1Id6m3qzKmV8x697R45dsX2JLtw==
X-Received: by 2002:a05:620a:2456:: with SMTP id h22mr691145qkn.292.1621447900188;
        Wed, 19 May 2021 11:11:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id g1sm136589qtr.32.2021.05.19.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:11:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ljQfS-00AnPK-Mv; Wed, 19 May 2021 15:11:38 -0300
Date:   Wed, 19 May 2021 15:11:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <20210519181138.GU1096940@ziepe.ca>
References: <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <20210518173334.GE1002214@nvidia.com>
 <YKQBACJCjsxeM3ro@t490s>
 <20210518194509.GF1002214@nvidia.com>
 <YKQjmtMo+YQGx/wZ@t490s>
 <20210518230327.GG1002214@nvidia.com>
 <YKRRgZmRMdk1vH7A@t490s>
 <20210519132842.GJ1002214@nvidia.com>
 <YKUcHfhQMbDnjXC7@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKUcHfhQMbDnjXC7@t490s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for the noise.

Not at all, it is good that more people understand things!

Jason
