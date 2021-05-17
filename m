Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C993828D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEQJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:55:24 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3284C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:54:08 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B5864C022; Mon, 17 May 2021 11:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621245243; bh=hQ3FIc3FP39hQ5sinVKlpsPMQdlr7pQOzU9Lg3Kuuuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THvcf4nEk20zx43KQ4LuIpoZy/4f04nE7K3wdJIUyHn93AEJ/Qd6PVjvLf30BEQ9A
         yQsa4HQILtkj07srQrxej3oRVG4EgZeUtlsyX2DnosEI1CtH0iKYukDUXXPY6IVbxY
         ZXYvC0RhiiuCn/qTVwET+ZYWJl46FTkaOXClh//Zt6gswNPHQPHoKT/FL/2ewvpvOD
         QvS9aq3YTz71mOF3Xl4uioBqbEGDKEvf7efSXPWJtzzr82a/r1V4IDtvmRNMBGHzHd
         HNY6k8IKx6tKEuDlk/hyt5nsYT12qAnmlsuPOBPO4X7CDpQWKLhbBjzasM6cx5y9TN
         liJdD+Tj8t16Q==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 10DD3C009;
        Mon, 17 May 2021 11:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621245242; bh=hQ3FIc3FP39hQ5sinVKlpsPMQdlr7pQOzU9Lg3Kuuuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4kmQtAPfPpp5uxDjwZJVSDRtBlkdcMvHGcC7EqjXyJnNXCvgheRE9z7yBRmPjWogE
         XPnL+vWpTZi7A9LL0SBl1i4VisYN+2IYeqgf5OI35lpD7+2DhjAH6HQSU0/u3mdh7k
         lEItSYNyetultBuJuCnsbzlR2V6vOW/H1zhie1TGQyXfL94evvDHe/uj1wjNhKf9OA
         XbrX262RhR9feraS4tXciTmMAw9djTAUj13+RLNw6FsjmqroVEcICPbT69TCUeNQFa
         FKnWeBfxKuGqNUYyAMOV4by40oQijgsnWWOyCUNicHz8IQs1dFf10MDn2oyzuOT5BS
         bc39PXNegUN5g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6f2eecd4;
        Mon, 17 May 2021 09:53:54 +0000 (UTC)
Date:   Mon, 17 May 2021 18:53:39 +0900
From:   asmadeus@codewreck.org
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 15/15] 9p/trans_virtio: Handle virtio_device_ready()
 failure
Message-ID: <YKI9I9qg2iISlz65@codewreck.org>
References: <20210517093428.670-1-xieyongji@bytedance.com>
 <20210517093428.670-16-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210517093428.670-16-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xie Yongji wrote on Mon, May 17, 2021 at 05:34:28PM +0800:
> Now virtio_device_ready() will return error if we get
> invalid status. Let's handle this case on probe.

The change itself looks good to me

It's going to be a pain to apply though because it depends on
https://lkml.kernel.org/r/20210517083557.172-1-xieyongji@bytedance.com
you just sent, so this won't apply to virtio maintainers on one hand,
and I can't take just this patch because it depends on the first patch
in the patchset (well if it weren't RFC)...

I guess sending the other patch to Linus fast-ish so it can go in virtio
tree would be the best way forward? other maintainers please advise, I'm
bad at this.


> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
