Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0135F728
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhDNPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhDNPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:01:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D75C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:01:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o13-20020a9d404d0000b029028e0a0ae6b4so538888oti.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWUtMV31lAE/hyg87N7iEfJU2y6qay0uOr7HTCluXiQ=;
        b=weX1bUpjRw6wuytQJlFfHNsn28nJPkkHmgBmJw8yPf3L2dHbbM5kfw3GHxlJBh1DyO
         BJkCg2eP4j3uyTHTdQaKSyyrOp+Fdowe+89rwe7wEGQbQm73jyYQTJ7L9wx49d6igFYd
         vbmQpzTiwPwqdGDeylnvV3vHpL+PWpFnvnzhRJ+IDnGQvkvXtwuLb+d5yUV9tHJCFx7s
         bOw6rogRUZEzwOFKIQ91VGxbwbpZd7+mDC+GgCrvp1IoZyasKbedKt0fyfNtq6M1NaxO
         7QzGAS3TRRrj5hg+1RxcPnAG82mKMruMgDVEaVQhzyw4zOZpmht7sd/ADU718gXGHYFJ
         +Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWUtMV31lAE/hyg87N7iEfJU2y6qay0uOr7HTCluXiQ=;
        b=WY1l40/NdgqhWuHI5vCy0So50m2sMgNRwbDcfGdST8rB3sdQxQP9/TU5O8O4EMgTa0
         9aNNVWikkiAZH5YsWIaT5nP9QVUoS8mjfIKMIEnOGPaMqxSvgmKes69drcOvBU8gFKzd
         bHfq3+6naHXjv5MyBQCrjCYF02hcrFNQmjpKufXQsaZe9v/B8Lobk/NYg02i/yQKJmdP
         HP8a0At7xIbk7ibVW8Bbmfh8iM7T8lqAmz3l1puhhDl2LPnn1bJ0ZIbRZwyHDoxvqSxd
         OMbHe5w8mLtwovJ2yXMP1TTV2/geCKt6vaPoIwlyolX+gOOgWa41P9kd3s7PEm/aQIHW
         c2Xg==
X-Gm-Message-State: AOAM533TpekZNIP4ywJRwf/sZIp6vxAI18VliyN4n7ubLzEV/UJdKEBx
        UVa9HC7/mhUdPpqyI484XqLqyQ==
X-Google-Smtp-Source: ABdhPJxDtOsCeDQQ/deHM1lftmwj2WSD1eWrJZcD1R9B4e21VGSd2wMo678cp9rC6umgF66U/MAcWg==
X-Received: by 2002:a9d:7f9a:: with SMTP id t26mr2801371otp.363.1618412491567;
        Wed, 14 Apr 2021 08:01:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z25sm337558otm.34.2021.04.14.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:01:31 -0700 (PDT)
Date:   Wed, 14 Apr 2021 10:01:29 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] remoteproc: stm32: add capability to detach
Message-ID: <YHcDyUap4cU8WNh6@builder.lan>
References: <20210331073347.8293-1-arnaud.pouliquen@foss.st.com>
 <20210331073347.8293-3-arnaud.pouliquen@foss.st.com>
 <YHYOd/vqeZCiqkpJ@builder.lan>
 <3df5317b-d28a-9362-6876-99442fdb8ef5@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df5317b-d28a-9362-6876-99442fdb8ef5@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Apr 02:23 CDT 2021, Arnaud POULIQUEN wrote:
> On 4/13/21 11:34 PM, Bjorn Andersson wrote:
> > On Wed 31 Mar 02:33 CDT 2021, Arnaud Pouliquen wrote:
[..]
> >> +		err = mbox_send_message(ddata->mb[idx].chan,
> >> +					&dummy_data);
> > 
> > Seems I posted my comment on v1, rather than this latest version. Please
> > let me know if we should do anything about this dummy_data.
> 
> Thanks for pointing this out, you are right, the mailbox driver is stm32_ipcc
> and it only sends a signal to the remote processor.
> 
> As message can be queued by the mailbox framework using a local variable seems
> not a good option. As this code is a copy/past of the kick and stop?
> I propose to get this one and I will send a new patch to fix the usage in the
> whole driver.
> 

That works for me, I've merged the two patches.

Thanks,
Bjorn
