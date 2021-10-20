Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5734347BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhJTJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:19:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A87C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:17:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 75so21975196pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E07XCh5aoq53PcE5WzOPIBZIArSMQcyYBT49q/CHH1k=;
        b=YS1zWbCHr5Ovs6rv+B5GSVK412fvzSoZ9HXM4oHMfkIz7W0864AfgzUrlqpAAMyjUV
         u97Algm4Fx3daGwkIGCGJG5T3hYlDR5W1dHoVpiwdzLtyY5MsnssB20V0hTWr8lPZkbz
         msrd2dLRwF/35DmPJ3+6hNsAW9qiRbDMEDEvAvIOt04P6H196raVUeI+CBRErfBeucpS
         AyDqql/OL1Ud3Xs5lO5B3pfYXuzCCrilrYgVmnwlOLiKrDg8WYasljKiR3DoRY8Pq6cZ
         KwJ/fMp7qij0yc9Oe7+Zl2sT0HlX1tb5V5qyzdP0DcCB8PKfevBH+6QyiRhExQ3LWjc+
         VnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E07XCh5aoq53PcE5WzOPIBZIArSMQcyYBT49q/CHH1k=;
        b=yiK8KyBn1bm+05AZ5upGzt0spUSrmYRpEj6nKFemODyp7BKBFmm+4Gn7g9e4gFswaB
         ML/bBOl7R0GoeKgiK5Ju1W6P9//Kwfe11fQueEgdYbphkjjV1D84SPI5opKquMxDWtH3
         8Re58Q0WGNiJSQ4hI1CA7h+76JxB/AtONQmhCuIE4zj1YISSyJuYjgRvB64b9r3JokU3
         nygNeKMWnzuMztxhSoy8orUYcqmlA3NIICELtm2KKk9ArlwOztgnZ1b61/9Rb2IyMBR2
         vfCphRDCycDfTgd4huMrVUkroBz9qlBvFrSdk5FimBMNLaAa5AAkwYx5nYmIR1zHTLk9
         1IHQ==
X-Gm-Message-State: AOAM532HB24v+MZa/H+uhiRsuDfmncaQ/z8crqERYaIWWb5hnhHyLJbg
        g5cZGQX2kjq1PqXjBq/whaKr7A==
X-Google-Smtp-Source: ABdhPJxcQN3jZntaqy7AG24AUDixZOEWeCrWoUCiBzdzUlJmnC63hptshpOOyZTK96lHxMPesbSj5Q==
X-Received: by 2002:a05:6a00:1707:b0:44d:47e1:9ffe with SMTP id h7-20020a056a00170700b0044d47e19ffemr5232102pfc.53.1634721444760;
        Wed, 20 Oct 2021 02:17:24 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id h24sm1898381pfn.180.2021.10.20.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:17:23 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:47:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, wsa@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211020091721.7kcihpevzf7h4d62@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
 <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 16:54, Jie Deng wrote:
> 
> On 2021/10/19 16:22, Viresh Kumar wrote:
> > On 19-10-21, 09:46, Vincent Whitchurch wrote:
> > >   static void virtio_i2c_msg_done(struct virtqueue *vq)
> > >   {
> > > -	struct virtio_i2c *vi = vq->vdev->priv;
> > > +	struct virtio_i2c_req *req;
> > > +	unsigned int len;
> > > -	complete(&vi->completion);
> > > +	while ((req = virtqueue_get_buf(vq, &len)))
> > > +		complete(&req->completion);
> > Instead of adding a completion for each request and using only the
> > last one, maybe we can do this instead here:
> > 
> > 	while ((req = virtqueue_get_buf(vq, &len))) {
> >                  if (req->out_hdr.flags == cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT))
> 
> 
> Is this for the last one check ? For the last one, this bit should be
> cleared, right ?

Oops, you are right. This should be `!=` instead. Thanks.

-- 
viresh
