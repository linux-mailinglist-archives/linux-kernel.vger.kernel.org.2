Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2D365C53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhDTPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhDTPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618933174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=coXw7bSB92l2OSOi2Pskhossq8vZZCyQYfDdNtE51LI=;
        b=e3ywpFDdhwINV5145gxaXjH538Dbb58zDQNLQnaOkzxq012j2O9onY62272+LnAUgrGJaJ
        cXUlQkrA8KqyCdPUeH5ph5A0rotNYXrJQj7wcmEromX971v+Tnc+KTDqoZIoIUUYWVzlmL
        lwUNGGcBHctQl8jTRDbc55rDTSpup0M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-w3dz9wAwN-uSvGgR0XBl3Q-1; Tue, 20 Apr 2021 11:39:32 -0400
X-MC-Unique: w3dz9wAwN-uSvGgR0XBl3Q-1
Received: by mail-qt1-f199.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so3547804qtw.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coXw7bSB92l2OSOi2Pskhossq8vZZCyQYfDdNtE51LI=;
        b=Ls+jt1uxCg9HLY4BygYjhxYPTIZaQRafgPt0e4k0aKUMXXd3ns/AESPARQl8jWdSlw
         jHXG17aAejWHknol1CXWkN9yldiN9VSx5KMEkBJslP7TDkSQBpio9gggycIxBnqz+nGV
         9GQlSSiJuXZs2GM7gcjTQDY13IKIO4nqFsqi0xaQEwXTJ1z90B/IF47KS1IlHzaqAPLS
         TITFC8MCQOCOvNsztuOk/982iT48vZALjdyS2tfVWrHvyMDMc0WUBzTCmaQb4DvRUPQV
         JjkQ4m41RWdLI8lQGcefQ0B+HXKjkZ5zqGqZuikYujemvitmkQL2/4UzwQ5cljTolqGF
         hWNQ==
X-Gm-Message-State: AOAM5316Kp4yHjpO2TeIAQ2Q/MX1EYt/F9E8J1QF2AijeJox7AwhssoJ
        jfL5dNS6TqWaEllcs/1ZiuqvUkAsTv/ExXg3cGGXNK7Zo2U2rRLjlDI72xsOVRhSm0HSyAX9ntD
        zIu32BAICe2O9clBDLOk3pKrm
X-Received: by 2002:ac8:4e16:: with SMTP id c22mr10856575qtw.354.1618933171844;
        Tue, 20 Apr 2021 08:39:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE/oMaWgtfj/To4K6pA6L6aSzn9oP92etGjIRHkk4pGYIgEbMrwLhaCy0IueXIi8VP6xiH0Q==
X-Received: by 2002:ac8:4e16:: with SMTP id c22mr10856551qtw.354.1618933171631;
        Tue, 20 Apr 2021 08:39:31 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id f12sm11633325qtq.84.2021.04.20.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:39:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v4 0/2] KVM: selftests: fix races in dirty log test
Date:   Tue, 20 Apr 2021 11:39:27 -0400
Message-Id: <20210420153929.482810-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:=0D
- add missing vcpu_handle_sync_stop() call in dirty ring test=0D
=0D
The other solution of patch 2 is here [1]=0D
=0D
I got another report that there seems to still be a race, but that one seem=
s=0D
extremely hard to trigger, even so far we don't know whether that could be=
=0D
ARM-only.  Since current fix should make sense already and fix real problem=
s,=0D
IMHO we don't need to wait for that.=0D
=0D
Paolo, I still kept the 2nd patch just for completeness, but feel free to=0D
ignore the 2nd patch if you prefer the other version, and I'll follow your=
=0D
preference.=0D
=0D
Thanks!=0D
=0D
[1] https://lore.kernel.org/kvm/20210420081614.684787-1-pbonzini@redhat.com=
/=0D
=0D
Peter Xu (2):=0D
  KVM: selftests: Sync data verify of dirty logging with guest sync=0D
  KVM: selftests: Wait for vcpu thread before signal setup=0D
=0D
 tools/testing/selftests/kvm/dirty_log_test.c | 70 +++++++++++++++++---=0D
 1 file changed, 59 insertions(+), 11 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

