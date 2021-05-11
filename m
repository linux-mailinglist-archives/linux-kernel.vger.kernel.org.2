Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E1F379CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEKCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhEKCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:25:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 19:23:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so418799pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LEnjyPPeB6lvEBpPeWNCTITVj6tamqcoGqJcOIK5Qp4=;
        b=KR2reNxL/sbflBFkWnnBu+sgMkVV93lU9doeUNOnFJF3KAkUX7sP/KByjvH/HCa59a
         OUOh9iFkpcJ4NBJF53E6XIeQTyIgOm9Gdc3SdewCI4leNSPFQxBKiL8Q8fGyWdlLAp+v
         R5XRszq02yz5+sCAx49Cg3SXSQz/ekgqXMLFdkmHB2M0a4kz4D0KjEHhVYQSa5nWdfol
         KrTaHaHrKGjo4vRot9Mq7rz1RJ7NVOA5L+9L/Gj2AFB163tt1la+KDqmthpxh1X9/GA5
         HEHak07eYEk2ygLvmtLytTIaBdTDGPgtWnKxAr2UAqgYa47JIBqxj46HxHtfSoNrN8BK
         Rc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LEnjyPPeB6lvEBpPeWNCTITVj6tamqcoGqJcOIK5Qp4=;
        b=E27LRctvfS/U21LTuiw/1ZxDUzQTIyixU+0hq5s7Z8rO5zFH9AooxQYvQ+Nvyln591
         OW7qOh1npRIaWvaqvB8buEIoZGR0PW9HsPbtouEKJS0SkWwubLXrWtu8CkKKvrSP7L0C
         G7ny2G30O0il80CeDLt7Zz0LY3rEd7d9fEW5zjVhtS2AevyIDYWU1M4yRR6NHI1yoAvB
         3eOoONRqzkrqEJ6gW4pHTAMAYDORzS1PC9JUXSnsT02ekuGpvXmsrBjqbmSZ2SijRoKU
         r1WsHzVXQiy3uwe1l4+jy01H/hqFMhdXYPgfymQDq16NfV8w7+FElwmXDF8w43ImRIcL
         rEOA==
X-Gm-Message-State: AOAM533/Q47hNw5lpRsgmi77W5/bG4xXXEVyIrsEsvy8t97oG5JDbMwf
        c51yDyl8kWZ3ZIHaZuzTn0E=
X-Google-Smtp-Source: ABdhPJzpOl5GUcKUw9u3zbEX0ghWK308O6Yu2PMXk99BNW5s0Jl5zlbAaKlAxHFBD9BnoJkewmZk1w==
X-Received: by 2002:a17:90a:450e:: with SMTP id u14mr31629260pjg.194.1620699835919;
        Mon, 10 May 2021 19:23:55 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id q24sm9502273pgk.32.2021.05.10.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:23:55 -0700 (PDT)
Date:   Tue, 11 May 2021 11:23:50 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/locking: make __down_common use flags previously
 saved
Message-ID: <20210511022350.GA97228@hyeyoo>
References: <20210424142823.3896-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424142823.3896-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, is there someone?

can you tell me if my approach was wrong, or Can I improve anything?
it was weird to me that __down_common disable / restores regardless of flag
that was previously saved
