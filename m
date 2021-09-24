Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D24175F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbhIXNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbhIXNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:36:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76FC06129D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:33:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x9so9470761qtv.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7PJQ49f2XQNsVpC/1cTituVVFDqoofyOlji1lyJ65Y=;
        b=MPJHXJSK62fiV7bY72s9psPD0qwrmH4+DSCY4SIpcq1V/qq7c2BkdfsmcaxbnZE5i3
         /DvF7FLnGlJFR6hfvLptQEy4IBMwpL963K/d7znelDInDKeXM0ZsyLxMQZHM7JZs5Ip0
         QynG3Y2Jovo34yHzcQ+gjUZ5rgopklx4kDUOC5yH5h4IbzUe6HYE4oTChIK1TS04Y5NT
         05EQCx9I1GD+unY3XX8rWaoIWbDoqEkxUd6D+SCxH47Tkt5pmURs2/PItpfgV9dwkNrl
         HYwRyR7RVlx5RtzLQAja7xmQJ5bm/9tbwJEXxjUi5kS/Fr4IkllyvWCWlP3oDNzBjA/6
         0qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7PJQ49f2XQNsVpC/1cTituVVFDqoofyOlji1lyJ65Y=;
        b=eAhS7h+dlBVfXMh5FTBQdZ5edrp5NGpfKsk2rR5SQBJ9VhamBNkWTMKBiya3x7kEcf
         o2yojAEBzNgp5rFVgMZrcfoRIrDqQvmYeIAt8GY7+T+TI4tbB0GkkFkUvm7GhDf5rlSh
         aR8Z4sjZfgtKcWIBO0Ll12ZB99AhueQKB/UEcL6AqwXQlzdaj0BCFJiCne7jUbQgWUIp
         O1GXHEOF7joL2QfEhFlBFgrqHSuLxWhxn2PkDfGKJurgliMnzDQ43/zZGQ795wWS+WhV
         PT2uOz7Sc2C1uDHJuAW3IHZyub0HZLpgorAfnJ7FrxCcvluloUUJqJzX5cQnW+yPJVDH
         rdJQ==
X-Gm-Message-State: AOAM530BJSeo0YPzI3T4mxdvcgfD5kah741mPVrHeQsz+JkM3ar5DYiM
        dFvI9oabyyO5s1c6lYtvrp8M3w==
X-Google-Smtp-Source: ABdhPJzGALBkia0iPtmjNoAr7JPtYRFEawKuGcqgeqOKn7YKM4EhxGhO7qWobDM3jezsg5ZghKh7lA==
X-Received: by 2002:ac8:687:: with SMTP id f7mr4255449qth.165.1632490402674;
        Fri, 24 Sep 2021 06:33:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d11sm862534qtb.39.2021.09.24.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:33:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mTlKL-005A7W-6H; Fri, 24 Sep 2021 10:33:21 -0300
Date:   Fri, 24 Sep 2021 10:33:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: fix potential NULL pointer access in
 tpm_del_char_device()
Message-ID: <20210924133321.GX3544071@ziepe.ca>
References: <20210910180451.19314-1-LinoSanfilippo@gmx.de>
 <204a438b6db54060d03689389d6663b0d4ca815d.camel@kernel.org>
 <trinity-27f56ffd-504a-4c34-9cda-0953ccc459a3-1631566430623@3c-app-gmx-bs69>
 <c22d2878f9816000c33f5349e7256cadae22b400.camel@kernel.org>
 <50bd6224-0f01-ca50-af0e-f79b933e7998@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bd6224-0f01-ca50-af0e-f79b933e7998@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:29:46PM +0200, Lino Sanfilippo wrote:

> So this bug is triggered when the bcm2835 drivers shutdown() function is called since this
> driver does something quite unusual: it unregisters the spi controller in its shutdown()
> handler.

This seems wrong

Jason
