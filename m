Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C431945AEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhKWW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhKWW1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:27:01 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F28C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:23:53 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so1115585otg.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PqPWpaKN9Ih5a2VjcG6Bb8Mw/WAw3kSHvfuLFZZUl5w=;
        b=jIEtDo5FU1eVjwMraHGXBd0vVJjsoyvWxY6fvIzjZdo7GNlBxDKMokcwpa4WMpx6aO
         fh1jYDYjseaKgmAQ7s03tKnEu8fLbTduK01vroxv+WzUg8K0hBjEttRjwrd3UumIRJ7T
         +udhelQx4pVrx4tHOpbFtwmqT4gcZafdmnQQCFEa9keOAGm0uHsYQd02JhRhjXuVSYvN
         SXkKLGYRZijhWiGUuGwwJjZi91ihFAckCsMAF+5NGUQczPGfXK9k/u5g3TK/pxCN8vqG
         v433r86M5GY+kMBC0btaMawqij9Eg574N57VIgk5DIQbXB6qld4JInqzasxc/9A7pOAf
         t4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=PqPWpaKN9Ih5a2VjcG6Bb8Mw/WAw3kSHvfuLFZZUl5w=;
        b=hyywSwbfteDzrf8K2J6o++h8xgG/27EFMD/WTHhqNfI68oOgKSwD58SIl4a1Zposwa
         mnko9cCvFDCz7dldlbhSdnbXk+c8tSfJ36gmnYbc0hu6SF8vNEQy3HT8bGMI0xT0c2E9
         FBzu7zENpCdSPgFNLiPSzZCXNKOCd36a6jT6b5h6DQM6G6a/nJV6FnIwt/a8YPPQvQhI
         SNJFvkxX76iIEAkvOkf0rXdiFLyX/W2ndwF4+ozBBR/mhGp9P+owzji4ACDl7hZeZz8v
         e458onYLYsS2vW9gnCM8lUE4v3bAmkdaZHpEPzh4Woh4p2FCWusOyGdgQ3vhmkQE99sp
         uQ+Q==
X-Gm-Message-State: AOAM532+OGCFga0uAH8H/OUhU0mMMD7Qq/zg4rt72tsH6jtRzGPsqoYq
        lJ+bUNi4cwIvsjeDylNo4taxlk73QrEUvhdnG4s=
X-Google-Smtp-Source: ABdhPJyk75LhwWzx/9pBMsw+cDhB/aLMP7+96cP9ihY/jsPSaIPUPQ9TUSigl+jzVo6++IWTFjCKrgpyO0keQN3I888=
X-Received: by 2002:a9d:7601:: with SMTP id k1mr8041992otl.356.1637706232683;
 Tue, 23 Nov 2021 14:23:52 -0800 (PST)
MIME-Version: 1.0
Sender: ndjarama@gmail.com
Received: by 2002:a9d:222e:0:0:0:0:0 with HTTP; Tue, 23 Nov 2021 14:23:52
 -0800 (PST)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Tue, 23 Nov 2021 22:23:52 +0000
X-Google-Sender-Auth: 0ccoHJ78kVU5GeGGP7osUx4NqCA
Message-ID: <CACa0hk-0Np9OuOLNy4LLCs__ps=L1J3sH2F1Au2X81vQuUzTEw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj, dostal jsi moje dva p=C5=99edchoz=C3=AD e-maily? pros=C3=ADm zkontrol=
ujte a odpov=C4=9Bzte mi.
