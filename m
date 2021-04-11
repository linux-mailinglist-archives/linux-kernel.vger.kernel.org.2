Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196DC35B642
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDKREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhDKREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 13:04:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6505C06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:04:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j7so5094374plx.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTSmYzl0sYL6U3pEfv9/5A9umdXLofLexJIK/i1h5Zk=;
        b=aGZRNPB9i1T5v1LnyERWcXsuHPaSVWOIfPQnazAlwIR+quNxw7UP0iCkYsm3ivAxQU
         xARoJTwrORQq/rGiJPtbohU3L2ghHnyKcZlrzUDyxBQmr9pWUuUJoNVzZ9A7PB6qm4ai
         dAqKhTk506ksOoYAX+ziyd4EaXEFaDn+hft6pYzHeD0WmDwV2sz3qMlEAE5i5XtO3v/m
         hVG/wxf/ghAJlvn+RXwlI0+Fx5LJFsBWIIIhgrkOgSC+3fF0rOMPl5J43ndvL9d4Ls0i
         Wwk6SvK5rrgv+1GCaXs0A8ipj51tdk+WoVj2OgW0VhURFPRC0zzMVVQOHgbCZ6+OHdN0
         yTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTSmYzl0sYL6U3pEfv9/5A9umdXLofLexJIK/i1h5Zk=;
        b=YNh/jgFpD0pS16HLnKEVClQq+bmEQu03YL41RpKC2JWncrUnZRZ2PXaJkYP0KVGYr/
         o7Lz7CVXkg1WqnG+nBF3fytG6udiDxAsJ/RVKOH4sT6lFVhRx6Eqkicrrd9Y3a44JHke
         7oepHiJpiFkRobdIJcSUL23g0P1fixL0WNadCgcSrfC/VW9hQk7wdZnVBj5mQkxkz7CQ
         4agR8RRylEZZ+3yNLgUvqAcuaorz/RmayixwYV4MEx9tCaTIQUH+2uXj7qfpEFfI0PoD
         xMAZRVW5I8fyJjWG5hOXcpVM2ys8CPJEazWUjw/okyW7CDj3cfDgkS7hqsoTl40hzkrJ
         kV/Q==
X-Gm-Message-State: AOAM532VUo8LrAwOXuzLfx5uUlk14DtBQCwUhdUMMiiHhI+0Tq8QXZGs
        FUOCkxt2AqGGZdzxnyaqRxpJtQ==
X-Google-Smtp-Source: ABdhPJzg39hrdEwl0SueoJk3pC6SZFmLPibg9kpsLtvX6G59lOrG9wELtpVVx7TyjNNjt53J1zXgMQ==
X-Received: by 2002:a17:90a:7045:: with SMTP id f63mr24626608pjk.35.1618160656008;
        Sun, 11 Apr 2021 10:04:16 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id x20sm8395692pjp.12.2021.04.11.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 10:04:15 -0700 (PDT)
Date:   Sun, 11 Apr 2021 10:04:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     netdev@vger.kernel.org,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Di Zhu <zhudi21@huawei.com>,
        Weilong Chen <chenweilong@huawei.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Colin Ian King <colin.king@canonical.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC iproute2-next] iplink: allow to change iplink value
Message-ID: <20210411100411.6d16e51d@hermes.local>
In-Reply-To: <20210410133454.4768-5-ansuelsmth@gmail.com>
References: <20210410133454.4768-1-ansuelsmth@gmail.com>
        <20210410133454.4768-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2021 15:34:50 +0200
Ansuel Smith <ansuelsmth@gmail.com> wrote:

> Allow to change the interface to which a given interface is linked to.
> This is useful in the case of multi-CPU port DSA, for changing the CPU
> port of a given user port.
>=20
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>

This may work for DSA but it won't work for all the device types vlan/macse=
c/... that
now use the link attribute.  It looks like the change link handling for tho=
se
device types just ignores the link attribute (maybe ok). But before support=
ing this
as an API, it would be better if all the other drivers that use IFLA_LINK
had error checks in their change link handling.

Please add error checks in kernel first.


