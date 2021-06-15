Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD663A8C23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFOXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhFOXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:01:13 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE173C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:59:07 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id y207so10207vsy.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=srjoCeGftWMuXSvErEPeSC1SDZoVoeF2JS5y37JB+DAboq5KeghttsfDByr8zBsd3q
         f5rvLrlDRQpJQq6zp81rm58pxKLr/MX6VcjbOILR44mZIKPc8pu2fLIT2/ucwpJExwEL
         f3fGM5hCH7B5Uv+zBqzzXyrG38M1oPH/+EvIj932NVBtbosyB6IN0aLCUm3mvRc/ii+G
         sVGLl5OPP5yWQeaRlkQ/rFBqHCjyMvfTpBZLvVlLrWpUCstiLT4jKIYn03UcyivGsM+K
         +LhI7NbT2gCqoqyxoVwt7zsZkHvEWOBQCu9HHRnzCU4Hf16m+ICHQzL4Ny9NFmh3p038
         lGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=U5Gn3xzgoTtQsBvk8x2iQWhfn0UoUhbPJRef9QuH2WR0Y2tlq10I/pe+Uu9snVE+q+
         Ot824u8oZe7V4C3tWTP2tJxGhps1saPbQMhBhNsP0r+olR1Vw78WD1wEy3kF9BBVc9xm
         1DV8VhE2tprd/yz5QfvtovHvMoLYXsFNr2H11OZE+TWPdOdU5drxgTgDImFJY20ylqFD
         Ukm11eA74QtIzfy4hk9CzTMT9YcOiH898ACEctBoGgYiucQBvZgKiF0grGDdFVJ58Dsw
         GdpguTO5x3sWc+Z6Oi1k/i1sUfZ2ulTvqxNnwdMZIbB6zMrQYjCDsltDl/c74hlgRIUs
         Q2zw==
X-Gm-Message-State: AOAM5332HtGFW1ISFX9mkbBAMebOSSyoqHI4V9Ml4TwQ7jrKzFW+uIfn
        TSOKV5FAKH8fNty6WOaKX2dhJo+YJAxENcvn6Hc=
X-Google-Smtp-Source: ABdhPJwNnegSc7zij6HoYi05LQkIG0KNWTjMLz9dZAtBKNtNjn6+FjawCz/SfW/j0AjrC7Py6j7mklPyRH6ISdS3iZ8=
X-Received: by 2002:a67:6606:: with SMTP id a6mr8477825vsc.51.1623797946915;
 Tue, 15 Jun 2021 15:59:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:25c4:0:0:0:0:0 with HTTP; Tue, 15 Jun 2021 15:59:06
 -0700 (PDT)
Reply-To: Lloydsbankgroup@mail.com
From:   llodys bank <llodysbank87@gmail.com>
Date:   Tue, 15 Jun 2021 22:59:06 +0000
Message-ID: <CAB7-GJWqbq-oz030A+grTM-ciKv08KPq4qtYCxCYm=1wZVSrLQ@mail.gmail.com>
Subject: =?UTF-8?Q?Dear_Beneficiary=2C_This_is_to_bring_to_your_notice_th?=
        =?UTF-8?Q?at_we_received_a_Telex_Network_Message_from_the_Internationa?=
        =?UTF-8?Q?l_Monetary_Fund_=28IMF=29_for_us_to_pay_and_transfer_the_total_s?=
        =?UTF-8?Q?um_of_=C2=A3500=2C_000_British_Pounds_Sterling_Only_as_a_Result_of?=
        =?UTF-8?Q?_Compensation_Trust_Fund=2FScam_Victim_during_our_Internationa?=
        =?UTF-8?Q?l_Networking_Program_held_at_United_Kingdom_on_the_6th_of_Ap?=
        =?UTF-8?Q?ril_2021=2E_However=2C_be_advised_to_quickly_contact_our_payment?=
        =?UTF-8?Q?_Center_immediately_by_forwarding_the_below_details_to_enabl?=
        =?UTF-8?Q?e_us_to_process_your_fund_through_our_online_banking_transfe?=
        =?UTF-8?Q?r=2FDirect_MOT=2D103_Telegraphic_wire_transfer_directly_into_you?=
        =?UTF-8?Q?r_bank_account_in_your_Country_or_by_Sending_to_you_your_Loa?=
        =?UTF-8?Q?ded_ATM_visa_card_through_the_FEDEX_COURIER_SERVICE_and_also?=
        =?UTF-8?Q?_to_enable_us_forward_the_copy_of_your_Legal_Fund_Origin_Cer?=
        =?UTF-8?Q?tificate_to_you_for_your_reference=2E_Full_Names=3A=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E?=
        =?UTF-8?Q?=2E=2E=2E=2E_Address=3A=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E_Mobile=2FWhats=2Dapp_No=3A=2E?=
        =?UTF-8?Q?=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E_Thanks_for_your_Cooperation=2C_Dr=2E_Mrs=2E_Sandra_Ko?=
        =?UTF-8?Q?hl=2C_Customer_Care_Director=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


