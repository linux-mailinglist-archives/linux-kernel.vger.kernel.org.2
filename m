Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5927331A410
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBLRup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:50:45 -0500
Received: from so15.mailgun.net ([198.61.254.15]:63486 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLRul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:50:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613152218; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZV7o/l5i92iIubII/VeD5vu9RAbY/6LR/SqAIkDMvEw=;
 b=oak5G126KyyxoC2Jul+2wH8ND1OBBZS0KKWJYaDdwA6KJHL6PrzY2epo1KfKB3Ossp0Lf/bt
 ld90kXpm7RbxMp5S1HphNA8OLUUvQqg3PfDcOsWQ/rL7J9T2H1ng/D/vjQtWIWhXoaSFEZUK
 Ixwc3/xnpV3qGpKP/ijz+aEhAhU=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6026bfbe8e43a988b75b5229 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 17:49:50
 GMT
Sender: subashab=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A263C43462; Fri, 12 Feb 2021 17:49:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: subashab)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F598C433C6;
        Fri, 12 Feb 2021 17:49:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Feb 2021 10:49:49 -0700
From:   subashab@codeaurora.org
To:     Alex Elder <elder@ieee.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Sharath Chandra Vurukala <sharathv@codeaurora.org>,
        davem@davemloft.net, elder@kernel.org, cpratapa@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net:ethernet:rmnet:Support for downlink MAPv5 csum
 offload
In-Reply-To: <1c4e21bf-5903-bc45-6d6e-64b68e494542@ieee.org>
References: <1613079324-20166-1-git-send-email-sharathv@codeaurora.org>
 <1613079324-20166-3-git-send-email-sharathv@codeaurora.org>
 <20210211180459.500654b4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1c4e21bf-5903-bc45-6d6e-64b68e494542@ieee.org>
Message-ID: <4694227d4e5a357f299df7f5444807b5@codeaurora.org>
X-Sender: subashab@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-12 07:01, Alex Elder wrote:
> On 2/11/21 8:04 PM, Jakub Kicinski wrote:
>> On Fri, 12 Feb 2021 03:05:23 +0530 Sharath Chandra Vurukala wrote:
>>> +/* MAP CSUM headers */
>>> +struct rmnet_map_v5_csum_header {
>>> +	u8  next_hdr:1;
>>> +	u8  header_type:7;
>>> +	u8  hw_reserved:5;
>>> +	u8  priority:1;
>>> +	u8  hw_reserved_bit:1;
>>> +	u8  csum_valid_required:1;
>>> +	__be16 reserved;
>>> +} __aligned(1);
>> 
>> Will this work on big endian?
> 
> Sort of related to this point...
> 
> I'm sure the response to this will be to add two versions
> of the definition, surrounded __LITTLE_ENDIAN_BITFIELD
> and __BIG_ENDIAN_BITFIELD tests.
> 
> I really find this non-intuitive, and every time I
> look at it I have to think about it a bit to figure
> out where the bits actually lie in the word.
> 
> I know this pattern is used elsewhere in the networking
> code, but that doesn't make it any easier for me to
> understand...
> 
> Can we used mask, defined in host byte order, to
> specify the positions of these fields?
> 
> I proposed a change at one time that did this and
> this *_ENDIAN_BITFIELD thing was used instead.
> 
> I will gladly implement this change (completely
> separate from what's being done here), but thought
> it might be best to see what people think about it
> before doing that work.
> 
> 					-Alex

Our preference is to stick with __LITTLE_ENDIAN_BITFIELD
& __BIG_ENDIAN_BITFIELD definitions similar to other
networking definitions.
