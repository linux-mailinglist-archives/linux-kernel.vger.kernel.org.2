Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1443A61C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhJYVv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJYVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:51:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36144C061745;
        Mon, 25 Oct 2021 14:49:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d9so12243239pfl.6;
        Mon, 25 Oct 2021 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=baPV4wjWZkGX1/OiILxvL9eAGAhGEPzvMBmxxzMUQ18=;
        b=QXLi5LxfSEiZQavsYMecHFC1Ryzi+j4JIobg4vPw2H51u+3Qpgk/qgk/ux/t1ReruM
         KiQESzV0bS9HJD+QdTRhClZDtSVjlkkab5WA6j2w3dZRfoFbPsPL0gBa/k/89DiD2kgv
         ttzh3g7mvljlgu6xKH6VRjJ0an+TfrtWlQDe32vWWSqYRY5m5AyHBToW+6c6WMkFtCDb
         iNUj6XPu9CN333mq03+/gZIkzsqEJPtKnvWpKB6z90AQW91h8WhfhO6x7hjbK00/sd+o
         RDj99muUDZ3+JeYLZUVzdbnIejOlLaajjMCi+a6XlYTnljUNCUtzUxpa89nTOiISnYCU
         eI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=baPV4wjWZkGX1/OiILxvL9eAGAhGEPzvMBmxxzMUQ18=;
        b=cXf2CxySb/XjS8U3nDd8yyHY8OrzvQ2eAgpfg4hW1eMV0ktsyKwQdWpcomIcwjDFU0
         ybzSeBGRg0d0/XQU4jOGEuteiTFXVOijU6qVoE4t27eEKyCCNzW4bvHgrDHgAytvcm2c
         DDGQf8zGu9mwsHW2Ay8gWR5SuVkRXOP6yVzIrCtRDKv8zSZAttvpqgqtwQfDroqcjLE3
         iDLWsRLdqtNna6sVgKsxy1WXVtWTcS7EwCSZrMnCyu3FYqKkY6/8/2xp6S8WadAgGuaz
         W8uUrQ9EDv8BooU4RBGPKl5UffrfyDcJSb4BAvOAhr92InOCRCR9bsvZR1AJ9Do9ghx+
         Ft3A==
X-Gm-Message-State: AOAM530YlNmUmRk66TWnky4dFWZTUuX2sBAi1PGqqTJu1aL6FAqR0htw
        t6NJDiXMInHRNjWZCgiqm5E=
X-Google-Smtp-Source: ABdhPJw1xycS/uWoVr3qeOLq5p9ffEYMa8CRtNzgPJKpeoMGS3IBSCUUq5cibp2J+FKWyHMhlzcgRQ==
X-Received: by 2002:a62:9282:0:b0:47b:d0e9:a3c4 with SMTP id o124-20020a629282000000b0047bd0e9a3c4mr18809568pfd.12.1635198570571;
        Mon, 25 Oct 2021 14:49:30 -0700 (PDT)
Received: from nuc10 (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id p23sm9676409pfw.61.2021.10.25.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:49:30 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:49:28 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, corbet@lwn.net,
        djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com
Subject: Re: [PATCH v2] slob: add size header to all allocations
Message-ID: <YXcmaNb4NXk7AcCd@nuc10>
References: <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
 <20211023064114.708532-1-rkovhaev@gmail.com>
 <be7ee3a6-9b3c-b436-f042-82bd3c416acc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7ee3a6-9b3c-b436-f042-82bd3c416acc@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:36:53AM +0200, Vlastimil Babka wrote:
> On 10/23/21 08:41, Rustam Kovhaev wrote:
> > Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
> > size header.
> > It simplifies the slab API and guarantees that both kmem_cache_alloc()
> > and kmalloc() memory could be freed by kfree().
> > 
> > meminfo right after the system boot, without the patch:
> > Slab:              35456 kB
> > 
> > the same, with the patch:
> > Slab:              36160 kB
> > 
> > Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
> > Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> 
> Seems overal correct to me, thanks! I'll just suggest some improvements:

Thank you, I'll send a v3.

