Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F58391058
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhEZGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhEZGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:10:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F81C061574;
        Tue, 25 May 2021 23:08:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so14587057pjp.4;
        Tue, 25 May 2021 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2WExFhxABosK9HdA5Exw+tJqAyhuyxwGR01JuKcZG7I=;
        b=nvUEpnKSNMg+lATpfc9iKd25eYuz+lmwlY2hwUbQ59hhJGiJ1sfeBWaHAGiZg+ALJR
         YZUKJX7kxDUSM1DUs/eLFUPSOuks8a0ZvlmhUsNcxvssi8Uq0isgFASlcDNpqj+yNu9A
         4D8OaIRiddbPxPOpXNiMDe4pg03ySUj76xFJmNe4L8X1WchPtY6Erx9o7Gfzbe3VWPkx
         EuGYxyQlQIfuQQ1MsfzTYSXsJhDw9n8OjO9xxHig6PDZMfcHZTCm0Q6AjswGm2jl6j9/
         /fYBUYBBEIVrOm6QNDdrrutpJS3CulLFti4z60qRmV8A65IfGYe+TXk9iIQq0/cNvUo2
         GAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2WExFhxABosK9HdA5Exw+tJqAyhuyxwGR01JuKcZG7I=;
        b=JMLePk2/qvh9ari1qxu6SqtAHd25TOcbqim6LA4vyBXNmMTor7OMHF6ZHWXRsQLjkN
         CGQjdGtV/SMfougtTc0oJCRqa0K5ctVSbE+4RcgItW4QS9n8eDDfitSnyyCn5l1vRbi/
         7+k5EqQHrbSJDAOKVuodir8bVX+IOTKQjYOMyiwpOnc0SX8CK52tIhl0PNeRGlekgUuj
         TUvYFOAQdoKJudaU7dIgCar15YPAB+/U5FjL3SsTS6HM1/JvWePoDAu45ojf65eC3J3m
         PEdzOra+LrY73x2P7mPVSY/JVYCFJNTUHHD2kji2jr0o2BRRJbLnOJz6XEg2zPaI/BN8
         3BSg==
X-Gm-Message-State: AOAM5303ldfuUZzSm753IKpPlO+XIwXP4LxY0YLAPd0tU5qtL3UfnzAw
        aSNlIADxQKRYmgf0TbnHDPg=
X-Google-Smtp-Source: ABdhPJyc7OznveGTyJZlJeHM+3qJLZE6EtSm001nzkbVfduaZZA9mngC7oQv1zo+bq/BQcu1KbYBpQ==
X-Received: by 2002:a17:90b:2305:: with SMTP id mt5mr1202534pjb.198.1622009328712;
        Tue, 25 May 2021 23:08:48 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-30.dynamic-ip.hinet.net. [1.171.3.30])
        by smtp.gmail.com with ESMTPSA id n12sm14098915pjk.48.2021.05.25.23.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 23:08:47 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        cy_huang@richtek.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] This patch series add Richtek RT6245 support
Date:   Wed, 26 May 2021 14:08:39 +0800
Message-Id: <1622009321-15157-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richtek RT6245 is a high-performance, step-down converter that can support
up to 14A output current with the wide input voltage range from 4.5V to 17V.

