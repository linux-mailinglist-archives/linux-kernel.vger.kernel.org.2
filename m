Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070D3EA2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhHLKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhHLKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:14:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB9C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:13:56 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o123so540807qkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=Y5sKw1spZ/O052U+fiJjGsh9m/MwWP/zNdlJTCR4120=;
        b=eAO0pz65etfgqrV3nsqSG1PJsMOsHoNHdhWxYpIA9bhJ3mIJnnAMMLI8zTGlbFK9qm
         pKqQAGoLadXNkr4eWt9F65IReAnZ4d7d83W7CF4l4PMtYu4BItrjuTOdO5AQoEHhQzf8
         Oj5/EbVkZ8Ya3sKrbWEg8r34vpuzd2MQCLQjiJJwSUaYX6A4zjhJDf7gVfbjFLXFV5n4
         r+1Ttj0XuWsv/fhgkOXyh5AHlo4PjLY4EWy/uATnST2mJJle2f4axO9xTnwL43SrvzDr
         3luHLqOMoV+DBBGMtsMuhxMKS1H873/TIhMgUdDJ6RVVPftM4a0bdN7BT8WqVggDnII5
         dhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Y5sKw1spZ/O052U+fiJjGsh9m/MwWP/zNdlJTCR4120=;
        b=RVGx185uKRU/qQ5OMzPzy8r9mgSuzTfOrz2BuWebhDwR5Vsa+2Pf2J/9zWUj03ab07
         fKASiwKbhOeGohTOPX5vxSOpw8BKjp7QnM7ZmV2Ig0m4fyh9Gf7owK6xh2nGOYagKqki
         XEfCvBDA0gyz6iywin79n4DhAPAzHamYJj2iVseuh7J0UzBpA306MXMiSrhnotDWb6L2
         QL9R6oL4y0pUi7C3+YAjOgsNAsaamRhUYA15xRRTDMiHkmCSUvXz9xVcetpIyba6Hy27
         3rByWsEKR+f1hTgxn949ietJrVjhtowOqLNCuY4QV2My6G/v42r00OJWxxjgazlcBlXN
         ipcw==
X-Gm-Message-State: AOAM533UxTNrYyG74wslbZSFEnxVq+xqCILt9UzH8IGTT1/KQsPk0vCc
        oLzpx6fOxcjyexmm3llI543jwQ==
X-Google-Smtp-Source: ABdhPJyxu/56TB7XXCkE/p4dsejcIlhOfQFi56EpBSXF+DnC3fdruMHMQOsfXNgpqETdNtXvzJDxGw==
X-Received: by 2002:a37:9244:: with SMTP id u65mr3747424qkd.46.1628763236076;
        Thu, 12 Aug 2021 03:13:56 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id s69sm1000540qka.102.2021.08.12.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:13:55 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: LDD 3rd ed. - It was: Re: read() via USB bus
In-Reply-To: <13470108.apdoE9Qb8s@localhost.localdomain>
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com> <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com> <YRDq530N/9uu2J0x@kroah.com>
 <13470108.apdoE9Qb8s@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1628763234_131750P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Aug 2021 06:13:54 -0400
Message-ID: <147449.1628763234@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1628763234_131750P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Aug 2021 11:45:45 +0200, "Fabio M. De Francesco" said:

> I've heard that your book, LDD 3rd edition, has become obsolete a long time
> ago and most sample code cannot anymore build. Reading what you wrote above
> seems to contradict what I've been told by others... I must admit that I've
> just had a print copy of it that I have not yet opened for reading, therefore
> maybe that I'm totally wrong in assuming the above.

The APIs have all changed a lot since the 3rd edition.

The concepts haven't changed that much. And given that the in-kernel APIs
have *always* been a moving target, being able to deal with the fact that
a given function now takes a 'struct foo*' rather than a 'struct bar *' is a very
necessary skill for anybody who's planning to do serious kernel work.



--==_Exmh_1628763234_131750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhFPRhAAoJEI0DS38y7CIcAf4H/ivD8eGOum+x8xNhmxiOl6iM
sWRLy6LceExHtenqGEqwgi55DBdK3fk0ermW5suUzGZBah6dEHqEgxPjU1d9KS3M
P5/yfx8vQU+r3/3mFa69MVGOgW3ijZhkBoE9CxUS2BcqOD/9yTs+CYZs5FE7CkCN
IIUVNayBYr5ZvF0UlJjg0VHQn7YxpFwwSjPpdJbdQySjdtezxDjCq6Nfw70jBq5J
/B87plonfrjrrJymISpBvVn6pangCThJ04XnAh3raOMWYtUDFeqjcL218EP1C119
Otf1IBp0by969VYXwhbEkYAFKVX5BGeN6LBTHAyCJ+4kHCaBQuRifcyPK1MPuzU=
=qRru
-----END PGP SIGNATURE-----

--==_Exmh_1628763234_131750P--
