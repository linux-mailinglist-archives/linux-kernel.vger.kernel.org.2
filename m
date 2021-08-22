Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5203F41B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 23:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhHVVOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhHVVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 17:14:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5ACC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:14:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c19so1419985qte.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=Iq1SujnG3JH+a2kGNfGJnQqyOoM6aLdw5U+VfLYXJ0Y=;
        b=PU9nfOiWvv0VN8KS/wODtjOoJjM8MAeLSO6vKpR67sKJz6FQLKk6vIDyz2IF4ZpqSb
         +kIp1F7oi95SnkE8flNO4VdVDyVw1hx0AXw8fDYd9IsawCMlf0VG30GZuxOUll9NGioE
         oj2wYPGUpOcKAwkgu1VN7DEAkFSl9ABvlvMM7eIUtnvuFzSWtCqdYWVtOMTzd0Q68mgr
         t/FtdmAzREo7Zkx7lvmt6bJcb6kPCQzawnk1058qe/xe7gPMjLK9GsA0HbRwluHQz1ts
         DNYggcfI5nIQWThr6oRUeXfL83Pt8+I33KGbXOimTwWJfDuVn90xnlIhC/lI/nDop5ua
         YdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Iq1SujnG3JH+a2kGNfGJnQqyOoM6aLdw5U+VfLYXJ0Y=;
        b=IBWDUp5hbigspVjpklPsvZ8NG8gOAfQEHa36tZ8oQwcGQParQHC41nF+s5I2T6SL4Z
         a/3Ugd9wh2LSCSosGVOQgMiqcTTS8x6+KiudDm7BEAYl3KDGCd+tggCvBztzeySduiW9
         sxjDMC2zX17jvbV59Mi/nlAQZthkVelMzgR4vyaazqMRaUiWfKtK7rwyQnruBW5xpvb0
         cavonuLzCjRFIwBjR6+vx9NcF5p2Lcyi1hKCrguKDlvpPeO+FX3tE8Yq9iH2ESIIq8uw
         t5OCwa7XCuYpQPmxWV3kx8+fKJa1eMyg3ZmddBDHmw2hwA8po9VpfpgSbt9fGDP5fSkJ
         H7Mw==
X-Gm-Message-State: AOAM530V4aqygfl6A96lk3HBzMxQjLX6o5ahNRqGOkHNvp7Hfkp+T0ZB
        vvEtAupYzbF0KnWYspwqgehOmA==
X-Google-Smtp-Source: ABdhPJzQl13WoFzcgMgvRTzo32fmZyRJeVk15lhsc3tNEWMF6fWpG/OE4YOilz/IVxp44A8cU2PxKg==
X-Received: by 2002:ac8:4f0c:: with SMTP id b12mr12283552qte.246.1629666845600;
        Sun, 22 Aug 2021 14:14:05 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id k186sm7464968qkd.47.2021.08.22.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 14:14:05 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
In-Reply-To: <2bf9925a-fad9-ad9a-c878-daa08fae7e07@infradead.org>
References: <438052.1629663003@turing-police>
 <2bf9925a-fad9-ad9a-c878-daa08fae7e07@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1629666844_136257P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Aug 2021 17:14:04 -0400
Message-ID: <440653.1629666844@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1629666844_136257P
Content-Type: text/plain; charset=us-ascii

On Sun, 22 Aug 2021 14:08:08 -0700, Randy Dunlap said:

> This fixes one build error for me but I am still seeing another one:
>
> ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

That's a different patch, am working on fixing that one now..

--==_Exmh_1629666844_136257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhIr4bAAoJEI0DS38y7CIcXpcIAJwgblFv8by6ZZjRRf7ciUC0
ZZ/Ro/5myoI3ENEBjWeQW29AHI56pMh6A2/E6GFGSPMzbH1dPB85DqS3r8B4hPYw
BWPjE+PpzskbA4UkipvGa+Js3R34kUtxLFZscXjNhArpCFUV6777HUGptgxSXx4b
UhzEmwCcStJelSr+IsU3MJRv7OlfEkwU5K14tDUvIBtv5RtkQSNXf43qPUfpXnIi
weT4eg/ThLkQDcoPW4jiUlx2O5XjuOrh2VXgP3+bJSXlQMYc4D7Tqx6ouRp5ANO1
m9phnqxFtwwQ3pQb8EryaJgHMXA6Tf03PnpuUDyoQru/8u87U/MhZLLkHTCQDB8=
=lhHr
-----END PGP SIGNATURE-----

--==_Exmh_1629666844_136257P--
