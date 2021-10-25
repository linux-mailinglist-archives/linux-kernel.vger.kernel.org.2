Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8B438EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhJYFMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:12:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FAC061745;
        Sun, 24 Oct 2021 22:09:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b143so12298wmd.1;
        Sun, 24 Oct 2021 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qH7PS/UlMczeVLNI4zJXq9uVeSNY0uh36oNK2kNW72I=;
        b=mMS23Ip4ic14XCF/vtvV4EIOwkeJ46TiJeR7LTBXxaujgU4mpi7no8dSAcgOESNQ4A
         0Gcu+hKyosfS86DYEClSQmFHtiPO8HLb9uunTD7MI3YORe12/dhHDC0c2l+flMxXVRnT
         gFn/9faBLD5NCuFfZnrGYvqKsrrkq35tD5jt29PeTD4LJ9KdO1RfvyBvT1re3pUpb7W+
         GBvz0zhXAfwLhYypbIb3FpQ1AzD+jyAUnxS2PgOUFlJWwgERdn+nOhQQ0lxxpt3aGdz/
         gjqTchBToMgljoWOS1XaaF0UsIAqN6kX+BZJNPpncWDDMc0BOKkl7vMUL/V+ypb6VlVQ
         t6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qH7PS/UlMczeVLNI4zJXq9uVeSNY0uh36oNK2kNW72I=;
        b=6eo7L6S8ZrJHckX4EWSisk0/PvcnZzAeANkxvJ02oyJH3YZxtPQrHhYTl9uPwHAkkb
         fH6A8qbw8v2UkVpf4PbXSn8F+2YUFWBx1bFDTkmlVXCx9P2zmclZah20Qe2KZzK/A4zy
         h/jhUb9oBJF5RYfSkB1Y5NZ7IIg2y85qy5CZ3zZq+h7mbVDSGufpARGj7cy4wStTHwp3
         BrV20X85W7MSrfJuYV1wZypCxJIN8u7JQ6Tyk2OJbmwzQkGAtw11jm7B66/fXKkFe910
         A8S7kE6iEsbJt2xATEMWZmZtbqo+5OKr6Z/fvIvA+X/jAMLLA/bgaN9wam1sFIrlskY5
         xqgw==
X-Gm-Message-State: AOAM531VHDRLoHaNlkonfn4+m+o+PlquIW9LaOcq/uPLI10HL9OucSl6
        0MDuNrAvJC6FOJiyxTTjtykEleZrl30=
X-Google-Smtp-Source: ABdhPJxONwA4KaiC1Z81DegA0HSqn0EWs2Md/2h5OcX7hu+EjQtg76ozrygwLzHycvg+0o1a8+ALCg==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr703477wmi.116.1635138580746;
        Sun, 24 Oct 2021 22:09:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06658ca10b404d232775.dip0.t-ipconnect.de. [2003:c7:8f4e:665:8ca1:b40:4d23:2775])
        by smtp.gmail.com with ESMTPSA id i9sm10990103wmb.22.2021.10.24.22.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:09:40 -0700 (PDT)
Date:   Mon, 25 Oct 2021 07:09:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 0/2] Docs: usb: update struct usb_driver, remove :c:func:
Message-ID: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update struct usb_driver and remove :c:func: for usb_register and usb_deregister

Philipp Hortmann (2):
  Docs: usb: update struct usb_driver
  Docs: usb: remove :c:func: for usb_register and usb_deregister

 Documentation/driver-api/usb/writing_usb_driver.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.25.1

