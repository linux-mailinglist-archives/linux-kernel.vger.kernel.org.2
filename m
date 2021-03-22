Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6501343A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhCVH2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEF0360295;
        Mon, 22 Mar 2021 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616398096;
        bh=v3NQpuyUOFyoh1J3JjoW6o0s74XJekrXBvKE0fvhocc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eqlkm/tcuo0eWlw3ChgW957jCzm4qOpwnw6ZALW/pTCb4zcWkUZB+MT4Ad4KJrcvX
         iX//alfSjXRMM4YTE3Ve1wQ7B0SeaDGHzepkygJbO6PuBx7uEWxtzOkNsEkE5Fj8jt
         AZF7kDkazEfFi8iw2L0x+ohQGrSi/jNgwzn6LnA8wzOlhSDDssCTzohFJXw/ZnJ0s+
         Lgf5lAWQhUsXWkcfVssafROaxZEBooossAJw6Rg9gmdqo2Ra7d04Zu8WIS3dqOAaK1
         qhfoxjBBusETohQhxq4+lbLgWlzyPbAJyn1jMvha56gSLT3D9eMaUnFcNZ/u0EDe38
         OkD3t5b292chg==
Subject: Re: [PATCH v2 0/3] drm/tilcdc: fix LCD pixel clock setting
To:     Jyri Sarha <jyri.sarha@iki.fi>, Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20210321083153.2810-1-dariobin@libero.it>
 <87d9ed919351d46ba914e16fc24ee77e@iki.fi>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <93551019-e3d2-0fbd-5953-422bdee1d5b7@kernel.org>
Date:   Mon, 22 Mar 2021 09:28:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87d9ed919351d46ba914e16fc24ee77e@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2021 21:08, Jyri Sarha wrote:
> On 2021-03-21 10:31, Dario Binacchi wrote:
>> The series was born from a patch to fix the LCD pixel clock setting.
>> Two additional patches have been added to this. One renames a misleading
>> variable name that was probably the cause of the bug and the other fixes
>> a warning message.
>>
> 
> Thanks you,
> 
> I think this looks good now.
> 
> Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>
> 
> For the series.
> 
> I'll wait a day or two if Tomi has something more to say and merge this 
> to drm-misc-next.

I had one comment about the print, but otherwise:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi
