Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134D3AA835
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhFQAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:41:40 -0400
Received: from gw.atmark-techno.com ([13.115.124.170]:36998 "EHLO
        gw.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhFQAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:41:37 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 4853D80451
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:39:29 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id r15-20020a62e40f0000b02902ec871096d3so2634316pfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 17:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kzwC23yl7EiPEJTyDQAXknKKdn4AQMgQSpCxCXmT79o=;
        b=QeC8pvV0Cl67goUZ/3O3eXYAUya20y5rQcHnXVREEysZaOZQu3F/MVkSzxQh8B9W1V
         +HoY9Lr+Tuc4GTGLQVB1lXL6/NAOYam9WPIfI5zFkq+U6O88bZxSZf19/d6FahkOwD4F
         UFLtepuaPBDtgTZHwC0MpNzo9uzXBWGSG3EkGq+4OeSrRvupW5yd6EtDnEu+ARHiyApm
         Lz8820XJ4eN6iMqd9Q3P/wftGFtAxBH7eJDlcwQPTOrzBcL2e3NI/kM67OXfJcSiUtF/
         XVLHajvF4lgm2juNez0CyZXW2motFQzBpjvPSf7+hiK44KYWUDmmdBRL1gNFzzStM5ad
         g8Ng==
X-Gm-Message-State: AOAM531PxQaOEqAaYt9gAse4Gkuj0MwrgViAVihD1Gjoxz+TXZmSo/9t
        RgrR+9n4mo+bORZSg2+qGhcAU1ncpvCkyFRow9BLqx3qaMqT7hCp2nTvMk5IKw2VwzrUMf3ToBl
        gXHhtP5BQ9aE9JI+q90+tfd2HxMv+
X-Received: by 2002:a17:902:bb90:b029:11a:cf7c:997c with SMTP id m16-20020a170902bb90b029011acf7c997cmr2127483pls.80.1623890368374;
        Wed, 16 Jun 2021 17:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS51UkDeEgbZVQN8Wk1n9noziQk43W9FAfw9kVNO3t3j63+6pTaR8t/Y11gTIfZgQLKda96A==
X-Received: by 2002:a17:902:bb90:b029:11a:cf7c:997c with SMTP id m16-20020a170902bb90b029011acf7c997cmr2127467pls.80.1623890368156;
        Wed, 16 Jun 2021 17:39:28 -0700 (PDT)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id mg22sm3149090pjb.26.2021.06.16.17.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 17:39:27 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1ltg45-00FKxj-UT; Thu, 17 Jun 2021 09:39:25 +0900
Date:   Thu, 17 Jun 2021 09:39:15 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Jianxiong Gao <jxgao@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YMqZswFnSNKk4Z7B@atmark-techno.com>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMqW+/gQvM+uWUTw@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Rzeszutek Wilk wrote on Wed, Jun 16, 2021 at 08:27:39PM -0400:
> Thank you for testing that - and this is a bummer indeed.

Hm, actually not that surprising if it was working without the offset
adjustments and doing non-aligned mappings -- perhaps the nvme code just
needs to round the offsets down instead of expecting swiotlb to do it?

Note I didn't look at that part of the code at all, so I might be
stating the obvious in a way that's difficult to adjust...


> Dominique, Horia,
> 
> Are those crypto devices somehow easily available to test out the
> patches?

The one I have is included in the iMX8MP and iMX8MQ socs, the later is
included in the mnt reform and librem 5 and both have evaluation
toolkits but I wouldn't quite say they are easy to get...

I'm happy to test different patch variants if Horia doesn't beat me to
it though, it's not as practical as having the device but don't hesitate
to ask if I can run with extra debugs or something.

-- 
Dominique
