Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586F9444928
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKCTvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:51:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385D0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:48:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v11so10781405edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J9SAkUehJPRhCiQNp3wmeJoEYzEYF5EHiRrehtn/67M=;
        b=jAf/qOWTtMiObuk2NcXVww1F7Cv2/iJbJlTgBDmPHirArlW1uSGhEIWZxyb1uQrRMD
         M/kX5BSJoa2/C6aP9v/L29OJSo++4xa0gogRzJUJHI0XDDoOHC4I4YvHsICEdiOqwio9
         y+fOSj+/Btx83syOTdL8H479YpULPJrhc0D94Ta79zmcs4jpVWw/JMQb0K3qUvW8raQC
         g7JXLhxF4T/PyykvBbjXiJ+Slf9qnGAXIKzUcu3M4hO/nZ/Xpm7T12MnLIhUFtMbqDQV
         bAHva2DxmqEwWBD/7A9bsTmNZe3kwEzRAwrwbLLEQhnCTfogNeWC6s9xbygaZ9K+0m6G
         cGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9SAkUehJPRhCiQNp3wmeJoEYzEYF5EHiRrehtn/67M=;
        b=xYDdhHdS7DixVwwaNQ6ixRdhtpbVxKsxMwUGVBwuOTaoPvObd8wfVjEI2GSg27LO7t
         Eusy1I7cnzAIlKU5ktSl0vNQiqS9t+p3AseoERGCbON3mO00nwgdbEUr5YqqQkvUDYwc
         JuLd5UznGpguBOb6C7u3ivFI/l6PSrZwEMSFnuSj6LBOxkDHVuAIHmj4LbSA429VZPOv
         GHLx9EvEgp4vLhdBmGDkfz8WxbBEjsImI01a1/bcm5T8WjIwV74kkU+H/Gr33Nyboul9
         eq22g/NjoZMkiFGwGmb2GUDidpQcCBnzf31iMq3SxXMNDYlGeZJQKRcxgl8Xl/wP4lep
         7LRg==
X-Gm-Message-State: AOAM530tcasqm+P+J3A6/zKz5BJLwZYLL8xRTkOt5u5LIsLjZh4HpaGy
        UH1nMFUEB+iVUBNSdbOiFns=
X-Google-Smtp-Source: ABdhPJxtMS2LuhOOpG5stG/w3Y3kspXbR8LZLyola3Qh8kXepT68jehzHKftsqvtYvbYT7NL2O2t6Q==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr29643201ede.152.1635968921588;
        Wed, 03 Nov 2021 12:48:41 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id d22sm1697866ejj.47.2021.11.03.12.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:48:40 -0700 (PDT)
Date:   Wed, 3 Nov 2021 20:48:37 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
 <YYLAXL4HjgBGuF91@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYLAXL4HjgBGuF91@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 05:01:16PM +0000, Mark Brown wrote:
> On Tue, Nov 02, 2021 at 10:41:38PM +0100, Ansuel Smith wrote:
> 
> > @@ -3064,7 +3065,7 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
> >  	if (change)
> >  		*change = false;
> >  
> > -	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> > +	if ((regmap_volatile(map, reg) || !map->bus) && map->reg_update_bits) {
> >  		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
> >  		if (ret == 0 && change)
> >  			*change = true;
> 
> I don't understand this change.  The point of the check for volatile
> there is that if the register isn't volatile then we need to ensure that
> the cache gets updated with any change that happens so we need to go
> through paths that include cache updates.  The presence or otherwise of
> a bus does not seem at all relevant here.

I put the check there to not duplicate the code. The idea here is:
if we are doing a regmap_update_bits operation on a no bus configuration
and the function have a dedicated reg_update_bits function, use that
instead of the normal _reg_read, check and _reg_write.
To workaround the CACHE problem, I can add a check and detect if cache is
disabled and only with that option permit to add a reg_update_bits
function to the map (for no bus configuration).

Again the problem here is in situation where lock is handled outside of
the read/write and the read/modify/write operation has to be done in one
go so splitting this operation in 2 step (like it's done for
regmap_update_bits) would be problematic.

Another solution would be to expose a way to change the cache externally
to the regmap operation so that if someone require cache operation and
require also a dedicated reg_update_bits, he can do that by implementing
that in his own function.
A third solution would be check if it's possible to cache the value
externally to function... Something that calls the reg_update_bits
dedicated function and then update the cache if needed.

But do we really need to add all this complexity when we can just deny
an option with cache enabled and force to use the normal way (else part
in this function)

Hope I was able to explain better why we need this change.

-- 
	Ansuel
