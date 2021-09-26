Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06515418841
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhIZLMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhIZLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 07:12:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33855C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 04:11:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so56153055edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+1z1RrCZDU4eUSXxu48fTP+rh2VRYtjLtHCM2Wvspk=;
        b=pEzW2ksS5HeGfr33QylIMIGTDgjsPV2g3iIcOrEDYbGF4bqBJ94bSEnEikBpUVIxYN
         Ep+dNv99oN4NydqKQKtDS4XKN20T/KTbEkOyrsTooiVmiLFOX6UKbUdpgpvFjKYbml7U
         G9ydfszhoLSEudCJXQCQHLWZYcJUj/MnH0RSkUDhQbBJib4oE1eJHCjlHwLD/DGirTss
         7i2lbORz18LJ+wR6AqUgeK9GU0R7Yro0zLnbZBBe1rl6HFGtBpLWlz3LJJQlfq3/Lf6l
         OlbMpPR7cC8XJ8wPhu2DUnAXmTPzqnHhL5msOimetezMT8HjExZvRVG1uKNWQ1ZWxIq2
         IH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+1z1RrCZDU4eUSXxu48fTP+rh2VRYtjLtHCM2Wvspk=;
        b=YRgwSezSl7GmOkjRy/Ni/OqbtbH8FaByl/A7o61PfYg6Miv6dLb5RJRNzyEzh/lpU5
         g0YuDhIjTi2Thoi9cCaZlqtbDQxTSF/ffAVmqkXgTCdckDAP6htEq6TFik3RW0v2siIk
         qQf5FVRzO4o13b58sxsrr/FrnBs4B9SgmcRKXeNWTpDXZLSTVXACqYH+RXgx8RwPNfkC
         gGOxMmumVgOjhsboxOpRDi4ViSYzrx3jssVvRVFmQac4TVgfYzO4+floum2lwcYmNEjY
         2V/m/8dwmcnV5CDzPb30BVGVdKUFtg9gqshAP+pX5f27IM1RpTxXxLH+5UpNqq0B2w2U
         espw==
X-Gm-Message-State: AOAM530SVyFH6y/WugSOqsmERzKZxpUWHpSZh6LOw/FmyKRO9Io0ORda
        2lC6OOmXq5RVg9XfuzRei10=
X-Google-Smtp-Source: ABdhPJxPPEVIAyL1G1s5mhQQTeLbtfKw26z+zbfNcpyGYYq41GRonsS37IYDTrnNA6qYrL0s12uPJw==
X-Received: by 2002:a50:da49:: with SMTP id a9mr17246354edk.281.1632654657215;
        Sun, 26 Sep 2021 04:10:57 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.pool212171.interbusiness.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id j2sm8692969edt.0.2021.09.26.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 04:10:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        guolongji <guolongji@uniontech.com>
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        guolongji <guolongji@uniontech.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove meaningless pstat->passoc_req check in OnAssocReq()
Date:   Sun, 26 Sep 2021 13:10:54 +0200
Message-ID: <5520271.xSIEuOTSxb@localhost.localdomain>
In-Reply-To: <20210926103014.30088-1-guolongji@uniontech.com>
References: <20210926103014.30088-1-guolongji@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 26, 2021 12:30:14 PM CEST guolongji wrote:
> kfree(NULL) is safe and the check 'if (pstat->passoc_req)' before kfree
> is not possible.
> 
> Signed-off-by: guolongji <guolongji@uniontech.com>
> ---

Why is it "not possible"? Do you get syntax errors? Are the logic and the 
result of the function altered? If not, control is certainly "possible".

Remember that something may be unnecessary and redundant even if 
it is still possible.

Regards,

Fabio


