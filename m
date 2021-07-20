Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1C3CF4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhGTGIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:08:07 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33892
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238724AbhGTGHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:07:38 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 80FDC40606
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626763647;
        bh=9bjnp4VdTOhlUgHVRYNbcFZSNnpvzt+yxsss2JuyjpA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UVBQ+GM9iYg2HyRLl+EXS8esp9pqprihMP/kh0fYmYLNIF694CDTJ7O4Q8627sg2h
         x11RL1VirF78L2aXZMWpu1YfxHqdbULFf6DVdQIERnriNtAphRV6qutgurd8/6AkNz
         SWasMv9wu0k3AAAQ+oGjzZWrGDsEjV1pEeV/Ly+zjffz4lSHlWmJF137hWRXVkQ/K/
         2EUT4k9/afODlQ1LS7B1XGqJN5N+rwuyYhVd/euzAFn1nm/hfxzIlVVjv6W/rLzQ2V
         JWoCx4d7G6+fmwIUNS9sTQIE67Uu6ZaVZXS+47QGVoSPZXaZKg9W6KItb5AYuaIIJV
         b6UiIVevv0aAg==
Received: by mail-ej1-f72.google.com with SMTP id y3-20020a17090614c3b0290551ea218ea2so1921674ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bjnp4VdTOhlUgHVRYNbcFZSNnpvzt+yxsss2JuyjpA=;
        b=H6pzihANimJ3itFIB+q5e6GLJFzoPkGm82F1ABKJyYXMbnVRf39Q2Kh5q8zKFfAe/G
         YCNV41hFdH04Ck8jaZbV0KMN67Vw7tlvy9WXGIyuvuFZqxhERsHce93BYLHEePwQ5Zhy
         Hdxoy6+piyFqtlE5uUi+OL9zIzciUdNf9umlT+sI8x/0WlJFeDAZY8xlHtb+FWt9w9At
         tY87kNXF0vLnnh9EUeYsTU5OO/q2E+4T7KpEDCJQoOVnNhUiQaORsSly/uvtoYrsVa5u
         WfuIXj0gxHC7oVtTk7W7PcHzudsT8BNfB9jcfNvCBwM96JODDLSf4o+GZ0fTEdVF+epf
         cxCQ==
X-Gm-Message-State: AOAM5328Oh3ZknXOPyRFMOPz3cVIrbsg1qo8fNSg2rCezfvCrNrnwxYa
        0EkHmcm3MCDm5T2q7wdBBHaN6vGxE2gt+DEOPsjUbnd1ubwm/e6/YtIuUDW9OI4Hde0nrySWU4J
        mZgNrtLKPwmGxL4XjeBfy+6Jupeh8uiwxQ0o4FFs7kA==
X-Received: by 2002:aa7:db54:: with SMTP id n20mr38976220edt.21.1626763645693;
        Mon, 19 Jul 2021 23:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfdAbxAfgsQyWVvVvL9el3lD1RTbIyD8t6txu7+Dc08cxsfYwo/u+BxJMkUjVK1cgq1/6sew==
X-Received: by 2002:aa7:db54:: with SMTP id n20mr38976208edt.21.1626763645579;
        Mon, 19 Jul 2021 23:47:25 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id i11sm8733359edu.97.2021.07.19.23.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:47:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete unneed variable "delay" on line 79
Date:   Tue, 20 Jul 2021 08:47:20 +0200
Message-Id: <162676353666.8616.3777556078126347689.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210624055627.22295-1-wangborong@cdjrlc.com>
References: <20210624055627.22295-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 13:56:27 +0800, Jason Wang wrote:
> "delay" variable on line 79 can be deleted by returning "0" on line 88.

Please use subject prefix matching subsystem
(git log --oneline -- arch/arm/mach-s3c).

Applied, thanks!

[1/1] Delete unneed variable "delay" on line 79
      commit: 8729ca2a6f2dd154e32b6d4858425ba29b012f7f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
