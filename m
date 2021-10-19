Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4E4332BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhJSJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbhJSJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:44:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30731C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:42:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 187so17104672pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZObreM2oofTkM3qJIYvGBPc4dPhqrsVSh4sl9pXqX94=;
        b=gvXmPjPnRSNvISobWg1zZ6bO0AluECpeMJn/Wtis+JgxiwNWlke4JGvx/mqVLqczl8
         4jegSqD2RFGK0e+025gFJmGB8Qvce8i7b/zZvQ5P1o4tLw1CzTJCwwCocqUq7fuHZO+p
         MysEs4HafXErdZiKjnpU0yu+cum9rB5wSlO9OOgu1EapetCEmzj0NnS7gBq21lAK4Hmb
         us2FlYi0wzPlsPFN+EMKrExs6+LEEyUnmsxebLREjpYBNZbdZXV2nC9luLFkNAXb785e
         VKs72+TSrOMuYyZ1MUsqyan//oK3gDLuHtSMWLNH5V4uXwMqvV5oIPkyMVN3VdplB57K
         d2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZObreM2oofTkM3qJIYvGBPc4dPhqrsVSh4sl9pXqX94=;
        b=A7qKwqcnJtvyR31r9TJstFcbT9IJUSLOM6idxpMmxntB65JLWQTxYEXgxiNcmilkRt
         /hQQUw5edjb5/sq24ncr2d8CZCXjgWPtErLK5KFINOzKfXwIAATmF0DIpvZFVi7hSler
         0EL7YEJ0MY25vEzzi/WIv67tPWBPnx1yshDUnc3ayzy867aG2CpuNlUbcThzZ7hQDILg
         rEH3+m7dXG3gCCQ+TU+Xf7P+CUmnMMUDmnUIrAlFf7Ow+2GKmFHh4exBS8lddWWGxUlV
         EiqFPhAjN5gLjTuCbBzh2LWNT28yUab0kv0FUeblCXlW3wpB1wWwUikaAADJ6kqvbcrH
         cOtw==
X-Gm-Message-State: AOAM531xIPN20TlLastRkc8aT4h94lMQeTapf97uJGnNCvTbQtWFZbaE
        5Hzj6x1hsvOgNcXFQAP/wVBcbw==
X-Google-Smtp-Source: ABdhPJxcbC3OBgUMO+Lzh3jDx/hudBuFmrzaHwnRyTDEgDNQv+z9BMlhRENFVRvc+ZiQhDZAdCws7A==
X-Received: by 2002:a63:154:: with SMTP id 81mr27360406pgb.38.1634636525679;
        Tue, 19 Oct 2021 02:42:05 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id u4sm2037379pjg.54.2021.10.19.02.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:42:05 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:12:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, wsa@kernel.org,
        jie.deng@intel.com, virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
 <YW6Rj/T6dWfMf7lU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW6Rj/T6dWfMf7lU@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21, 11:36, Greg KH wrote:
> What is the "other side" here?  Is it something that you trust or not?

Other side can be a remote processor (for remoteproc over virtio or
something similar), or traditionally it can be host OS or host
firmware providing virtualisation to a Guest running Linux (this
driver). Or something else..

I would incline towards "we trust the other side" here.

> Usually we trust the hardware, but if you do not trust the hardware,
> then yes, you need to have a timeout here.

The other side is the software that has access to the _Real_ hardware,
and so we should trust it. So we can have a actually have a completion
without timeout here, interesting.

-- 
viresh
