Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5299349E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCZBSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:18:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10839 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhCZBSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:18:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616721491; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=dbqyO5xp+Xc0AkR2FMEhZNoheUZwZy/NovyVB8pJPrw=; b=G+LZg/qR5p3NqZrKG5JqpNQZSTmqR2Z8h4H7NBDdE1w21Jij5JoaZAHjKasovaJo+tiyyT1i
 4mFZwvDZLPEe4x02wgYYD7XCekKAicR38DLeR7kimDUX8G02KXr+HzWkCxUJOi9ln3QYPmGO
 pV7MYprHBrdQNufHxxng7226yNg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 605d364aa2ab6642db9fc505 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Mar 2021 01:18:02
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F5BAC433CA; Fri, 26 Mar 2021 01:18:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67323C433CA;
        Fri, 26 Mar 2021 01:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67323C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 26 Mar 2021 06:47:56 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v3] f2fs: allow to change discard policy based on cached
 discard cmds
Message-ID: <20210326011756.GE8562@codeaurora.org>
References: <1615886958-717-1-git-send-email-stummala@codeaurora.org>
 <3c453b72-892f-7044-2edd-224b82202608@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c453b72-892f-7044-2edd-224b82202608@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

This latest v3 patch needs to be updated in f2fs tree.
The f2fs tree currently points to older version of patch.

Please make a note of it.

Thanks,
Sahitya.

On Tue, Mar 16, 2021 at 07:08:58PM +0800, Chao Yu wrote:
> On 2021/3/16 17:29, Sahitya Tummala wrote:
> >With the default DPOLICY_BG discard thread is ioaware, which prevents
> >the discard thread from issuing the discard commands. On low RAM setups,
> >it is observed that these discard commands in the cache are consuming
> >high memory. This patch aims to relax the memory pressure on the system
> >due to f2fs pending discard cmds by changing the policy to DPOLICY_FORCE
> >based on the nm_i->ram_thresh configured.
> >
> >Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
