Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53A3FF0AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbhIBQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbhIBQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:01:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:00:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v1so1478762plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7bksqvlJuwZZLTVUa7ZM8nLi12BV8MFhzZg9kE/y8oc=;
        b=cegq78Ia0zomEPN7lo5RD/uizEjOa0e45fbRFyc0TN1pcIGRMZubuiEBuXfANDL/pq
         YTSr1o4cJJOVPY12nKNWOrqj8cAYj56luDYdeoaTrDHMUUucyzyryRUbYFNl/khAOXqa
         zYKulAEqCLl3Rf692/vCb/Frp92/gVSTYnam2c0234GMFpCuEUD3EqzjKqUka5pDexvs
         vCpfoTvSGrLASUelQObVpV1NXWJgGe2TE067SvLHgLXwO0GGJC1BWVK+39SgfGLPgBVd
         +vrYE1i98yt7/FhiqsJlud/PR0W4VlI8infK/kg8DUiJLwjx8WNpK5iojFSnRDBRHeEa
         uqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7bksqvlJuwZZLTVUa7ZM8nLi12BV8MFhzZg9kE/y8oc=;
        b=sEuISRgrTdsruwBd/EhIaEJiO1ixRcg3epRa1+4yIHmTEF2DwMXwZSW7GHJA4bAEKQ
         xFRH6zy08xbj9Z/ku8/iv7VzBnVsTNeWT/e+1j3Q9vb2zuPwChhxVGLYf1HjRwx5eFZF
         G+FQuJtbJencCKQ+EkKJI7YbghuzSUxyQSUHdepXulz8GGhnrsTJZPcO11TPA0VRZ+9l
         rWyaiePyCdsXqyNVAKxHa1NuFIX7evQof5khK49RZ2evm8t4lcJVMadCBD3GnKSX6VpB
         sfFIXzG4P5UO5L0/odtaVJJN0KoTuHReTlu1lZUjMPRPbakSsjyb9aB9pi2F3ilMiKCj
         B7KQ==
X-Gm-Message-State: AOAM533b6NB0ZrJg+wPKo0Y6H6lZa6+kmOIetGv41hRl7V/tfEGzeruK
        Xn88Z1j3LPUw+auE0ryZP9kzD4gJQj2tmRDicJ0=
X-Google-Smtp-Source: ABdhPJzNinvRCSIEGGwdv8S8QbYuOM2fLZxJnZuGeV90lFZu9XcNRnXFv+gDwZv5ASuGDhqXka3VnBMvtRqrY7JvkmM=
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr4572194pjg.79.1630598442205;
 Thu, 02 Sep 2021 09:00:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:1acd:0:0:0:0 with HTTP; Thu, 2 Sep 2021 09:00:41
 -0700 (PDT)
Reply-To: phillipknight903@gmail.com
From:   Phillip Knight <doodonvivi@gmail.com>
Date:   Thu, 2 Sep 2021 09:00:41 -0700
Message-ID: <CAE0mfsdmxZrBfd33bDB2gvpmSbTmWjjqdbxJuLa_F+8Ckk7oOg@mail.gmail.com>
Subject: =?UTF-8?B?TmfGsOG7nWkgY2hp4bq/biB0aOG6r25nIHRow6JuIG3hur9uLA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpOZ8aw4budaSBjaGnhur9uIHRo4bqvbmcgdGjDom4gbeG6v24sIHTDtGkgdmnhur90IHRo
xrAgbsOgeSDEkeG7gyB0aMO0bmcgYsOhbyBjaG8gYuG6oW4gYmnhur90DQp24buBIGNoaeG6v24g
dGjhuq9uZyBn4bqnbiDEkcOieSBj4bunYSBi4bqhbiBi4bqxbmcgY8OhY2gNClTDoGkga2hv4bqj
biBlbWFpbC4gQ2jDum5nIHTDtGkg4bufIMSRw6J5IMSR4buDIHRow7RuZyBiw6FvIGNobyBi4bqh
biBy4bqxbmcgbmfGsOG7nWkgY2hp4bq/bg0KdGjhuq9uZyBUw6BpIGtob+G6o24gRW1haWwgY+G7
p2EgYuG6oW4NCsSRw6MgxJHGsOG7o2MgY2jhu41uIGzDoCBuZ8aw4budaSBjaGnhur9uIHRo4bqv
bmcgbsSDbSBuYXkgKE1vbG90dGVyeSAyMDIxKS4gQ8OhaSBuw6B5DQpuxINtIGLhuqFuIGtp4bq/
bSDEkcaw4bujYyAxLDggdHJp4buHdSDEkcO0IGxhIHbhu5tpIHTGsCBjw6FjaCBsw6AgbeG7mXQg
dHJvbmcgbmjhu69uZyBuZ8aw4budaQ0KY2hp4bq/biB0aOG6r25nIMSRxrDhu6NjIGNo4buNbg0K
KFRo4bujIHPhu61hIHLEg25nIG7Eg20gMjAyMSkNCkxpw6puIGjhu4cgduG7m2kgTXIuIFBoaWxs
aXAgS25pZ2h0LCB04bqhaSDEkeG7i2EgY2jhu4kgZW1haWwgbsOgeQ0KKHBoaWxsaXBrbmlnaHQ5
MDNAZ21haWwuY29tKQ0KY2hvIHZp4buHYyB4w6FjIG5o4bqtbiBnaeG6o2kgdGjGsOG7n25nIGNo
aeG6v24gdGjhuq9uZyBj4bunYSBi4bqhbi4NCsOUbmcuIFBoaWxsaXAgc+G6vSBjaG8gYuG6oW4g
Ymnhur90IGzDoG0gdGjhur8gbsOgbyDEkeG7gyBjw7MgxJHGsOG7o2MgcXXhu7kgY2hp4bq/biB0
aOG6r25nIGPhu6dhIGLhuqFuLg0KTeG7mXQgbOG6p24gbuG7r2EgeGluIGNow7pjIG3hu6tuZw0K
