Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B203268C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBZUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:30:22 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:26594 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhBZUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:20:49 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 33827A163C;
        Fri, 26 Feb 2021 21:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=HYwggw/rUhqt
        s+zGKcM84ztpkAeb1/6OJ4uaan+TtPg=; b=KSc4e8noNmMygy2cqk5eDRdnyZHK
        8ie/YJwNhKV1RYo9YJlkmaJZzZoHU2Xy+UaSdrrzYdG8umvzh6TjMq1xg3OVTBb1
        CARoY2EcmejceqvDAWFdYRpQEoEAa2hmWyIETMt7kUqe92BYCP3OT7QWXGJiGJys
        G3De0Poukg+SMMROXKFPJoAwJ6AqJK6oXghdB7RSdvj96okvs+beHnI7NcAVkSA+
        35Sj79ZJo48Im0dcYkJxadfFK0OHeFJWv5rWz4HQwRwQF7oJLfz0t45Ba0EKjaou
        qc8A1G2PufD+GdqGN/98QTLXwC73B8q8Proj4aYGfIGaqZ0ZAHrw3477Bw==
Subject: Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
To:     Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
 <20210225135951-mutt-send-email-mst@kernel.org>
 <s5hblc7opok.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <50921122-85f3-14d1-abf1-e20875403771@opensynergy.com>
Date:   Fri, 26 Feb 2021 21:19:58 +0100
MIME-Version: 1.0
In-Reply-To: <s5hblc7opok.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.2021 21:30, Takashi Iwai wrote:> On Thu, 25 Feb 2021 20:02:50 
+0100,
> Michael S. Tsirkin wrote:
>>

[snip]

>> If you want to merge it yourself instead, also please say so.
> 
> I don't mind who take the patches, although it looks more fitting to
> merge through sound git tree if judging from the changes put in
> sound/* directory.

Then should I update the MAINTAINERS and add Takashi instead of
Michael, or should I put both of you there?


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

