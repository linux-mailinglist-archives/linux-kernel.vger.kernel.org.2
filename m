Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7482843AAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhJZEMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:12:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5586 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZEMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635221384; x=1666757384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+JLfUEiHL7SJGj04hhiD/zPeyJs8My/lEUe11JBlcNs=;
  b=mzT2eGCDlFC/6MKy2+BIaobiL9Ztpry6zZibFKbZg1PWVpaeKThHHr2D
   al5hN6FKiSY7zitwh3PrUK80dIvZGvtgV/q0G3XtdTdULt4GLxrkPwH6X
   txMNAGb+PxbWNm0c62y9lwsQIJd56hPLU3+PMkAUltYKjWBZqnlW3Jz7F
   RKoL8mPB9UnDqObRFVm6dbUNu4p+sX7Z0HzvHy1RrE+1LGdY46+QdaWOF
   3bqcP45s0kyRv/Vl7eYkGe1pTFEIWgNkTsZlmfrZU589kZJSyTV/RR01I
   kg6VWiphn0eV/9tQGNxZ43vEeIrT8KV5DHIsxamC2EvZHWib44HB/yhfb
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,182,1631548800"; 
   d="scan'208";a="188610937"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 12:09:43 +0800
IronPort-SDR: RrCMofBBp8IRzYHLPH/SZ0Zllk10EIPdQQc3AZ1TThPjiMqDC1QlwtloSf3cWb5EjJwSLvs/ZP
 FD9YDeinbTJ6UladwcVxwt+33kmNik0bFVk9J9poFEMEzv+5EXeLxAmAcTOVbRm7WjK2lp2onM
 fCyNJdW15EQxbo290LDfD2gg+Mb96H74kPsvRwvTq6PZ6Acj2zFl3CA0nIXaeL38UiJEqlbQYp
 47EOc2v73KtIq+XINHhIhoyn/CW0IR8HV5rz8596YBCVDNOErgOHka+HjdS/JGJVaFrV59iqa+
 ktCcSezInjMy7GQahJchc9oU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 20:43:41 -0700
IronPort-SDR: Kbt6fj7jk2I0Kv/jAyJAdSvqipuHx8urkpow35xdKEjmx5CW+EFeQwnQDE5+e5bZxWq9w7XkEa
 80fQROPI4KnT/bQhbJT4KpQDM5ZmmEqR1VdoCjAdA14YQvF7wJF9iBmcXS2kaMjcDr0jKfMYql
 8gCfxaJ+hAvkqpdVnegJaYFQkhfWPcTJ28b+XNdiOCSEC9xRDrQxy1lG1skhK8a6AWRexPtMvS
 wb9Yh0N0Nb7j0mYSea/Wgu5xrsI0TuTB/Du1GZ6wb1wbmz4KL9dHwuhICbifd0hRlT02IQHCtR
 Q2g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 21:09:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hddd36RpYz1RtVn
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:09:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635221383; x=1637813384; bh=+JLfUEiHL7SJGj04hhiD/zPeyJs8My/lEUe
        11JBlcNs=; b=DKiFHqmsdCyIynuZlnXWrs+dBUkNUy0K4PZ57luCa1bGZ4ZvLog
        eGV4oOk3LKmDQi8bdAgxZbfuzIQ+MPJwwyJ19K+bNmhBDTOaXekKMjJz2y+oNHGR
        Y8jqhQ6Tv88tpdzmNrAxBTc6WZMOjmdEIFhQcdW6bTP83d26Yskho3+TkCOTpArZ
        ayLsOqpuv0jxlY8u66jZuR25zzj/CKQbqTDr/p5qRs96Ze+dYXSjrT544c2O91Sg
        Z64Z9O3+MBtmvTo+bmK1QMPh0P7HIXyJwDZ9DPmIf6fZfpXx0TBsTTBzefbuCr38
        h+qO4Jsu0STtFvb9zMwd31rJvC5/DYYvw6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Sow0ur6L403L for <linux-kernel@vger.kernel.org>;
        Mon, 25 Oct 2021 21:09:43 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hddd319ypz1RtVl;
        Mon, 25 Oct 2021 21:09:42 -0700 (PDT)
Message-ID: <81a99dd1-0ef6-9bd0-31c0-b0934023746b@opensource.wdc.com>
Date:   Tue, 26 Oct 2021 13:09:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] driver/ata: fix potential null pointer dereference on
 pointer last_sge
Content-Language: en-US
To:     Chengfeng Ye <cyeaa@connect.ust.hk>
Cc:     linux-kernel@vger.kernel.org
References: <20211025131304.17226-1-cyeaa@connect.ust.hk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211025131304.17226-1-cyeaa@connect.ust.hk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/25 22:13, Chengfeng Ye wrote:
> The pointer cs_desc could be null if the loop is not
> executed, so there is a potential NULL-PTR dereference
> issue. Fix this by adding a null check before dereference.
> 
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> ---
>  drivers/ata/sata_sil24.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 06a1e27c4f84..2bd595da799f 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -785,6 +785,8 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
>  		sge++;
>  	}
>  
> +	if (!last_sge)
> +		return;
>  	last_sge->flags = cpu_to_le32(SGE_TRM);
>  }

I do not think that this fix is necessary: sil24_fill_sg() is called only if the
qc has ATA_QCFLAG_DMAMAP set (see sil24_qc_prep()) and that in turn is only set
if ata_sg_setup() sees at least one sg entry. So the loop in sil24_fill_sg()
will always be executed for qc marked with ATA_QCFLAG_DMAMAP and so last_sg
cannot be NULL.

-- 
Damien Le Moal
Western Digital Research
