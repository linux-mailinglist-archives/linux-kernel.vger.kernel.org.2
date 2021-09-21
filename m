Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B16413311
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhIUMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhIUMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:02:03 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:00:35 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y197so12899894iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=XBC+0OKoohEVObm9nznvHJgGd/s1Zh0hgNVG+HHsQ+6bh34AeCBF/Bje7XrXJHO10P
         6oL98fAiLJScC6du+taJQW+zXJl0o7XoilQW1OAUO5UBfu7qx4bY2P4agtLQyhlzuocV
         iQSqIRoQO5kCbfQRFjbc7eanNil2T9VAaWq8c6T9Djk+1+xEk+pB73y81tw9DN622cFF
         vccuw3xjQDHpJWlhmxDg4BDrFMqXixGYT0K0JMYn7FGWatfy84UoZu0mNvq6FAIIxUta
         8nCeQn6pw9VH/8wuGV3sIwCV6P/wkGQB2PTZVE0nA4Tzsq/CV+tpIA/6cm3oCF4XoJLw
         PCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=21LJoUSU53/vslwrfO93sscq5HkI3TCQRWqNvN+GkrZxc+tsqADPV0GKxPmHWEPCMX
         ebGhwMw9yKlXQdekRoExPFVuzLz7Zy813ON7uQlQDiILX07l69nZnYARAEsHzPg6WmYQ
         vnZkQRvq0Z/GixRcx88DWf6/nhabjDlE+Bj4TY/PD1tIWYmpx0m81tPBgqP/p5DV//DP
         w8QUSK65dOf9Iap2BiwQA3xKhlmKjITh6WRDRrZcWzlNE9eLmFsBzIYKuF6u9J6aHX1Y
         SM0icQwkCoVj+G/uhtoDIkOZoR+Sf62eEirXAGiwJ+/7AYq5FGOFShDttSFDDFh4couQ
         LXUA==
X-Gm-Message-State: AOAM532rdaUvHPnFWemqgmH5VlcWX62cQoAWwazKIWbZZdqoFjkWEGcz
        pPpA/AF4GJ5qn5Uv5RxzqzgaarA9+nlrgtfari4=
X-Google-Smtp-Source: ABdhPJz1hWPpksc1M/HZukXO0wFZ0sa+FU1mF2J+kxKlEpMOOKigahH7N+uRBF76lApXBAyzStAnwYwdDRxnTkHgE/A=
X-Received: by 2002:a5d:84d2:: with SMTP id z18mr20414048ior.52.1632225633060;
 Tue, 21 Sep 2021 05:00:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2d0b:0:0:0:0 with HTTP; Tue, 21 Sep 2021 05:00:32
 -0700 (PDT)
Reply-To: tonysiruno9@gmail.com
From:   Tony Siruno <barrjosephobieke82@gmail.com>
Date:   Tue, 21 Sep 2021 12:00:32 +0000
Message-ID: <CAM3utH0S0jWj_u6-cf853s+QRUD2XnN__UrC6BJRo2R4pk+oQQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warum schweigen Sie? Ich hoffe, es geht Ihnen gut, denn jetzt habe ich
Ihnen diese Mail zweimal gesendet, ohne von Ihnen zu h=C3=B6ren. Heute
komme ich von meiner Reise zur=C3=BCck und Sie schweigen =C3=BCber die Post=
, die
ich Ihnen seit letzter Woche gesendet habe. Bitte lassen Sie mich Ich
kenne den Grund, warum Sie geschwiegen haben. Ich habe mir
vorgestellt, warum Sie mir nicht sehr wichtig geantwortet haben.
Bitte, Liebes, ich brauche Ihr ehrliches Vertrauen und Ihre Hilfe. Mit
meiner guten Absicht kann ich Ihnen vertrauen, dass Sie die Summe von
12.500.000,00 Millionen US-Dollar in =C3=BCberweisen Ihr Konto in Ihrem
Land, wenn m=C3=B6glich, melden Sie sich bei mir, um weitere Informationen
zu erhalten. Ich warte auf Ihre Antwort und bitte lassen Sie es mich
wissen, als zu schweigen.

Herr Tony Siruno.
